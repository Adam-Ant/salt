include:
  - docker

/volumes/minecraft-creative:
  file.directory:
    - user: root
    - group: root
    - mode: 755

/etc/docker-compose/minecraft-creative/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml
    - makedirs: true
    - user: root
    - group: root
    - mode: 600
    - dirmode: 700

  dockercompose.up:
    - pull: true
    - require:
      - file: /etc/docker-compose/minecraft-creative/docker-compose.yaml
      - file: /volumes/minecraft-creative
      - sls: docker
