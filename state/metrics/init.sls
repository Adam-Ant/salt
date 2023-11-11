include:
  - docker
  - nginx

/etc/docker-compose/metrics/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml
    - makedirs: true

/volumes/metrics:
  file.directory:
    - makedirs: true

/volumes/metrics/blackbox.yml:
  file.managed:
    - source: salt://{{ slspath }}/blackbox.yml
    - require:
      - file: /volumes/metrics

metrics:
  dockercompose.up:
    - name: /volumes/metrics/docker-compose.yaml
    - pull: true
    - require:
      - sls: docker
      - dockercompose: nginx
      - file: /volumes/metrics*
