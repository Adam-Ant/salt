include:
  - docker

/etc/docker-compose/drone-runner/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml.jinja
    - template: jinja
    - context:
        drone_rpc_secret: {{ pillar.drone.rpc_secret | yaml }}
        hostname: {{ grains.id | yaml }}
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root

  dockercompose.up:
    - pull: true
    - require:
      - file: /etc/docker-compose/drone-runner/docker-compose.yaml
      - sls: docker

