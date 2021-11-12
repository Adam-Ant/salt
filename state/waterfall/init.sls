include:
  - docker

/volumes/waterfall:
  file.directory:
    - user: 853
    - group: 853
    - mode: 755

/etc/docker-compose/waterfall/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml.jinja
    - makedirs: true
    - user: root
    - group: root
    - mode: 600
    - dirmode: 700
    - template: jinja

  dockercompose.up:
    - name: /etc/docker-compose/waterfall/docker-compose.yaml
    - require:
      - file: /etc/docker-compose/waterfall/docker-compose.yaml
      - sls: docker
