include:
  - swarm

/volumes/swarm-files/drone-runner.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml.jinja
    - template: jinja
    - context:
        drone_rpc_secret: {{ pillar.drone.rpc_secret | yaml }}
        hostname: {{ grains.id | yaml }}
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
