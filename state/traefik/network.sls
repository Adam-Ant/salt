include:
  - swarm

/volumes/swarm-files/network.yaml:
  file.managed:
    - source: salt://{{ slspath }}/network.yaml
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
