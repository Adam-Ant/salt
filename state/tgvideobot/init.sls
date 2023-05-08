include:
- swarm

/volumes/swarm-files/tgvideobot.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml.jinja
    - template: jinja
    - context: {{ pillar.tgvideobot | json }}
    - mode: 0644
    - user: root
    - group: root
