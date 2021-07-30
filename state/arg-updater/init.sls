include:
  - docker

/volumes/arg-updater/config.yaml:
  file.managed:
    - source: salt://{{ slspath }}/config.yaml.jinja
    - template: jinja
    - context: {{ pillar["arg-updater"] | json }}
    - makedirs: true
    - user: root
    - group: root
    - mode: 644
    - dirmode: 755


/etc/docker-compose/arg-updater/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml
    - makedirs: true
    - user: root
    - group: root
    - mode: 644
    - dirmode: 755
  dockercompose.up:
    - name: /etc/docker-compose/arg-updater/docker-compose.yaml
    - pull: true
    - require:
      - file: /etc/docker-compose/arg-updater/docker-compose.yaml
      - sls: docker
