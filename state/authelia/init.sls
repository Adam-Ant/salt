include:
- swarm
- traefik.network

/volumes/authelia/configuration.yml:
  file.managed:
    - source: salt://{{ slspath }}/configuration.yaml.jinja
    - template: jinja
    - context: {{ pillar.authelia | drone }}
    - makedirs: true
    - mode: 0600
    - dirmode: 0700
    - user: root
    - group: root

/volumes/swarm-files/authelia.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
