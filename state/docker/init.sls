include:
  - .install
  - watchtower

/etc/docker/daemon.json:
  file.serialize:
    - dataset_pillar: docker:options
    - serializer: json
    - user: root
    - group: root
    - mode: 644

/etc/default/docker:
  file.absent: []

docker:
  service.running:
    - enable: true
    - watch:
      - pkg: docker-ce
      - file: /etc/docker/daemon.json
