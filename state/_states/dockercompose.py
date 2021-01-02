import logging
import os
import re
import sys

import salt.ext.six

try:
    import compose.cli.command
    from compose.service import ConvergenceStrategy

    HAS_DOCKERCOMPOSE = True
except ImportError:
    HAS_DOCKERCOMPOSE = False

MIN_DOCKERCOMPOSE = (1, 5, 0)
VERSION_RE = r"([\d.]+)"

log = logging.getLogger(__name__)

def __virtual__():
    if HAS_DOCKERCOMPOSE:
        match = re.match(VERSION_RE, salt.ext.six.text_type(compose.__version__))
        if match:
            version = tuple([int(x) for x in match.group(1).split(".")])
            if version >= MIN_DOCKERCOMPOSE:
                return "dockercompose"
    return (
        False,
        "The dockercompose state module not loaded: "
        "compose python library not available.",
    )


def up(name, **kwargs):
    ret = {"name": name, "changes": {}, "comment": "", "result": False}

    path = name
    if os.path.isfile(name):
        path = os.path.dirname(name)

    try:
        project = compose.cli.command.get_project(project_dir=path)
    except Exception as e:  # pylint: disable=broad-except
        log.error(e, exc_info=True)
        ret["comment"] = e.message if hasattr(e, "message") else str(e)
        return ret

    service_names = kwargs.pop("services", None)
    recreate = kwargs.pop("force_recreate", False)
    strategy = ConvergenceStrategy.always if recreate else ConvergenceStrategy.changed

    services = project.get_services(service_names)
    plans = project._get_convergence_plans(
        services,
        always_recreate_deps=recreate,
        strategy=strategy,
    )

    for cont in plans:
        (action, container) = plans[cont]
        log.debug("docker-compose action for %s is %s" % (cont, action))
        if action != "noop":
            if action == "create":
                ret["changes"][cont] = "Creating container"
            elif action == "recreate":
                ret["changes"][cont] = "Re-creating container"
            elif action == "start":
                ret["changes"][cont] = "Starting container"

    try:
        kwargs.pop("silent", None)
        up = project.up(
            service_names,
            silent=True,
            always_recreate_deps=recreate,
            strategy=strategy,
            **kwargs
        )
    except compose.project.ProjectError as pe:
        ret["comment"] = pe.message if hasattr(pe, "message") else str(pe)
        try:
            tb = sys.exc_info()[2]
            while tb.tb_next:
                tb = tb.tb_next

            errors = tb.tb_frame.f_locals['errors']
            for cont, err in errors.items():
                ret["changes"][cont] = err
        except Exception:  # pylint: disable=broad-except
            log.error(pe, exc_info=True)
        return ret

    except Exception as e:  # pylint: disable=broad-except
        log.error(e, exc_info=True)
        ret["comment"] = e.message if hasattr(e, "message") else str(e)
        return ret

    ret["result"] = True
    return ret
