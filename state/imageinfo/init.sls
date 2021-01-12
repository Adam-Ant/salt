include:
  - docker

/etc/docker-compose/imageinfo/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml
    - makedirs: true
    - user: root
    - group: root
    - mode: 664
    - dirmode: 775
  dockercompose.up:
    - name: /etc/docker-compose/imageinfo/docker-compose.yaml
    - require:
      - file: /etc/docker-compose/imageinfo/docker-compose.yaml
      - sls: docker
