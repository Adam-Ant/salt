include:
  - .mounts
  - docker

python3-docker:
  pkg.installed:
    - version: latest

join swarm:
  module.run:
    - swarm.joinswarm:
      - remote_addr: {{ pillar.swarm.master }}
      - token: {{ pillar.swarm.token }}
    - require:
      - pkg: python3-docker
    - onlyif:
      - fun: cmd.retcode
        cmd: {%raw%}'docker info --format "{{eq .Swarm.NodeID \"\"}}" | grep -qFw true'{%endraw%}
        hide_output: true
        ignore_retcode: true

