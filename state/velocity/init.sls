include:
  - docker

/volumes/velocity:
  file.directory:
    - mode: 755

/etc/docker-compose/velocity/docker-compose.yaml:
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
      - file: /etc/docker-compose/velocity/docker-compose.yaml
      - file: /volumes/velocity
      - sls: docker
