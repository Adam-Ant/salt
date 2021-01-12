include:
  - docker

/etc/docker-compose/watchtower/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml.jinja
    - context: {{ pillar.watchtower | json }}
    - makedirs: true
    - user: root
    - group: root
    - mode: 600
    - dirmode: 700
    - template: jinja
  dockercompose.up:
    - name: /etc/docker-compose/watchtower/docker-compose.yaml
    - require:
      - file: /etc/docker-compose/watchtower/docker-compose.yaml
      - sls: docker
