include:
  - swarm
  - traefik.network

/volumes/epicgames-free/config.json:
  file.managed:
    - source: salt://{{ slspath }}/config.json.jinja
    - template: jinja
    - context: {{ pillar["epicgames-free"] | json }}
    - makedirs: true
    - user: root
    - group: root
    - mode: 644
    - dirmode: 755

/volumes/swarm-files/epicgames-free.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root

