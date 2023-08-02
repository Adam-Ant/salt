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
    - source: salt://{{ slspath }}/docker-swarm.yaml
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
