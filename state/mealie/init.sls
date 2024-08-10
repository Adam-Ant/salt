include:
- swarm
- traefik.network

/volumes/mealie:
  file.directory:
    - makedirs: true
    - user: 911
    - group: 911

/volumes/swarm-files/mealie.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
    - template: jinja
    - context: {{ pillar.global| json }}

/volumes/restic-targets/mealie.yaml:
  file.managed:
    - source: salt://{{ slspath }}/backup.yaml
    - mode: 644
    - user: root
    - group: root

