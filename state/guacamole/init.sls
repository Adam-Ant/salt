include:
- swarm
- traefik.network

/volumes/guacamole:
  file.directory:
    - makedirs: true
    - user: 70
    - group: 70
    - mode: 0700

/volumes/swarm-files/guacamole.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml.jinja
    - template: jinja
    - context: {{ pillar.guacamole | json }}
    - makedirs: true
    - mode: 0600
    - dirmode: 0600
    - user: root
    - group: root
