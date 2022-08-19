include:
- swarm
- traefik.network

/volumes/bitwarden:
  file.directory:
    - makedirs: true
    - user: root
    - group: root
    - mode: 0700

/volumes/swarm-files/bitwarden.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
