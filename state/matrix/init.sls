include:
  - docker
  - nginx

/etc/docker-compose/matrix/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml
    - makedirs: true

/volumes/web/www/spritsail.io/.well-known/matrix/server:
  file.serialize:
    - serializer: json
    - makedirs: true
    - dataset:
        m.server: matrix.spritsail.io:443

/volumes/web/www/spritsail.io/.well-known/matrix/client:
  file.serialize:
    - serializer: json
    - makedirs: true
    - dataset:
        m.homeserver:
          base_url: https://matrix.spritsail.io

/volumes/matrix:
  file.directory:
    - makedirs: true

/volumes/matrix/config.toml:
  file.managed:
    - source: salt://{{ slspath }}/config.toml
    - require:
      - file: /volumes/matrix

matrix:
  dockercompose.up:
    - name: /volumes/matrix/docker-compose.yaml
    - pull: true
    - require:
      - sls: docker
      - dockercompose: nginx
      - file: /volumes/matrix*
