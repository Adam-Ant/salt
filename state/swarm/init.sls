include:
  - .mounts
  - docker

python3-docker:
  pkg.installed:
    - version: latest

join swarm:
  cmd.run:
    - name: "docker swarm join --token {{ pillar.swarm.token }} {{ pillar.swarm.master }}"
    - require:
      - pkg: python3-docker
    - onlyif:
      - fun: cmd.retcode
        cmd: {%raw%}'set -o pipefail; docker info --format "{{eq .Swarm.NodeID \"\"}}" | grep -qFw false'{%endraw%}
        python_shell: true
        hide_output: true
        ignore_retcode: true

