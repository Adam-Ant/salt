import logging
import os
import re
import sys

import docker

try:
    import compose.cli.command
    from compose.service import ConvergenceStrategy, Service

    HAS_DOCKERCOMPOSE = True
except ImportError:
    HAS_DOCKERCOMPOSE = False

MIN_DOCKERCOMPOSE = (1, 5, 0)
VERSION_RE = r"([\d.]+)"

log = logging.getLogger(__name__)


def __virtual__():
    if HAS_DOCKERCOMPOSE:
        match = re.match(VERSION_RE, compose.__version__)
        if match:
            version = tuple(int(x) for x in match.group(1).split("."))
            if version >= MIN_DOCKERCOMPOSE:
                return "dockercompose"
    return (
        False,
        "The dockercompose state module not loaded: "
        "compose python library not available.",
    )


def up(name, **kwargs):  # pylint: disable=invalid-name
    ret = {"name": name, "changes": {}, "comment": "", "result": False}

    path = name
    if os.path.isfile(name):
        path = os.path.dirname(name)

    try:
        project = compose.cli.command.get_project(project_dir=path)
    except Exception as err:  # pylint: disable=broad-except
        log.error(err, exc_info=True)
        ret["comment"] = err.message if hasattr(err, "message") else str(err)
        return ret

    test = __opts__["test"]
    pull = kwargs.pop("pull", False)
    recreate = kwargs.pop("force_recreate", False)
    service_names = kwargs.pop("services", None)
    strategy = ConvergenceStrategy.always if recreate else ConvergenceStrategy.changed

    services = project.get_services(service_names)

    # Attempt to pull the images first
    if pull and not test:
        log.info("Pulling docker images for %s", project.name)
        try:
            project.parallel_pull(services, ignore_pull_failures=False, silent=True)
        except compose.project.ProjectError as pe:
            return _project_error(pe, ret)
        except docker.errors.NotFound as notfound:
            return _image_notfound_error(notfound, ret)

    plans = project._get_convergence_plans(
        services,
        always_recreate_deps=recreate,
        strategy=strategy,
    )

    for cont in plans:
        (action, _) = plans[cont]
        log.debug("docker-compose action for %s is %s", cont, action)
        if action in ["create", "recreate", "start"]:
            ret["changes"][cont] = (
                f"Would {action} container"
                if test
                else f"{action.removesufffix('e').title()}ed container"
            )

    # Nothing to do; exit early
    if len(ret["changes"]) == 0:
        ret["result"] = True
        return ret

    if test:
        ret["result"] = None if ret["changes"] else True
        return ret

    try:
        project.up(
            service_names,
            silent=True,
            always_recreate_deps=recreate,
            strategy=strategy,
            **kwargs,
        )
    except compose.project.ProjectError as pe:
        return _project_error(pe, ret)
    except docker.errors.NotFound as notfound:
        return _image_notfound_error(notfound, ret)
    except Exception as err:  # pylint: disable=broad-except
        log.error(err, exc_info=True)
        ret["comment"] = err.message if hasattr(err, "message") else str(err)
        return ret

    ret["result"] = True
    return ret


def _find_service(tb):
    while tb.tb_next:
        if (
            tb.tb_frame
            and "self" in tb.tb_frame.f_locals
            and isinstance(tb.tb_frame.f_locals["self"], Service)
        ):
            return tb.tb_frame.f_locals["self"], tb

        tb = tb.tb_next

    return None, None


def _image_notfound_error(infe, ret):
    try:
        tb = sys.exc_info()[2]
        # Try to find the frame where 'self' is a compose.Service
        service, _ = _find_service(tb)
        if service:
            ret["changes"][service.name] = str(infe)
        else:
            ret["comment"] = str(infe)

    except Exception:  # pylint: disable=broad-except
        log.error(infe, exc_info=True)

    return ret


def _project_error(pe, ret):
    try:
        tb = sys.exc_info()[2]
        # Find the last frame in the stack
        while tb.tb_next:
            tb = tb.tb_next

        # Extract per-container errors from the stack frame
        errors = tb.tb_frame.f_locals["errors"]
        for cont, err in errors.items():
            ret["changes"][cont] = err

    except Exception:  # pylint: disable=broad-except
        log.error(pe, exc_info=True)

    # Extract any message from the ProjectError
    ret["comment"] = pe.msg
    return ret
