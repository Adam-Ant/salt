include:
- swarm
- traefik.network

podfetch-directories:
  file.directory:
    - makedirs: true
    - user: root
    - group: root
    - names:
      - /volumes/podfetch/podcast
      - /volumes/podfetch/db


/volumes/swarm-files/podfetch.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml.jinja
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
    - template: jinja
    - context: {{ pillar.global | json }}
