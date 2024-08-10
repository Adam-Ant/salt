include:
- swarm
- traefik.network

/volumes/homepage:
  file.directory:
    - makedirs: true
    - user: root
    - group: root

/volumes/swarm-files/homepage.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml.jinja
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
    - template: jinja
    - context: {{ pillar.global | json }}

/volumes/restic-targets/homepage.yaml:
  file.managed:
    - source: salt://{{ slspath }}/backup.yaml
    - mode: 644
    - user: root
    - group: root

