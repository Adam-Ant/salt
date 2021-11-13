include:
  - docker

/volumes/bungeecord:
  file.directory:
    - user: 853
    - group: 853
    - mode: 755

/etc/docker-compose/bungeecord/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml.jinja
    - makedirs: true
    - user: root
    - group: root
    - mode: 600
    - dirmode: 700
    - template: jinja

  dockercompose.up:
    - pull: true
    - require:
      - file: /etc/docker-compose/bungeecord/docker-compose.yaml
      - file: /volumes/bungeecord
      - sls: docker
