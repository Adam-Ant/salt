include:
- swarm
- traefik.network

/volumes/wireguard:
  file.directory:
    - makedirs: true
    - user: root
    - group: root
    - mode: 0700

/volumes/swarm-files/wireguard.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
    - template: jinja
    - context: {{ pillar.global | json }}

/volumes/restic-targets/wireguard.yaml:
  file.managed:
    - source: salt://{{ slspath }}/backup.yaml
    - mode: 644
    - user: root
    - group: root

