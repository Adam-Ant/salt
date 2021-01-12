include:
  - docker

/volumes/wekan:
  file.directory:
    - user: 999
    - group: 999
    - mode: 755

/etc/docker-compose/wekan/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml
    - makedirs: true
    - user: root
    - group: root
    - mode: 600
    - dirmode: 700
  dockercompose.up:
    - name: /etc/docker-compose/wekan/docker-compose.yaml
    - require:
      - file: /etc/docker-compose/wekan/docker-compose.yaml
      - sls: docker
