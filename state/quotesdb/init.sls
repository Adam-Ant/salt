include:
  - docker

/volumes/quotesdb/config/quotedb.cfg:
  file.managed:
    - user: root
    - group: root
    - mode: 600
    - dir_mode: 700
    - makedirs: True
    - source: salt://{{ slspath }}/quotedb.cfg.jinja
    - context: {{ pillar.quotesdb | json }}
    - template: jinja

/etc/docker-compose/quotesdb/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml.jinja
    - context: {{ pillar.quotesdb | json }}
    - makedirs: true
    - user: root
    - group: root
    - mode: 600
    - dirmode: 700
    - template: jinja

  dockercompose.up:
    - name: /etc/docker-compose/quotesdb/docker-compose.yaml
    - require:
      - file: /etc/docker-compose/quotesdb/docker-compose.yaml
      - sls: docker
