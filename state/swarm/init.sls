include:
  - .mounts
  - docker

docker-deps:
  pkg.latest:
    - pkgs:
      - python3-docker

join swarm:
  swarm.joinswarm:
    - remoteaddr: {{ pillar.swarm.master }}
    - token: {{ pillar.swarm.token }}
    - onlyif:
      - fun: cmd.retcode
        cmd: 'docker info --format "{{eq .Swarm.NodeID \"\"}}" | grep -qFw true'
        hide_output: true
        ignore_retcode: true

