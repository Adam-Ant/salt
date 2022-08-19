include:
  - swarm

/volumes/swarm-files/traefik-net.yaml:
  file.managed:
    - source: salt://{{ slspath }}/network.yaml
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
