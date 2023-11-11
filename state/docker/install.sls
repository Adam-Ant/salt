/etc/apt/sources.list.d/docker.sources:
  file.managed:
    - source: salt://{{ slspath }}/docker.sources.jinja
    - template: jinja
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root

docker-deps:
  pkg.latest:
    - pkgs:
      - gnupg
      - ca-certificates
      - docker-ce-cli
      - python3-pip
    - require:
      - file: /etc/apt/sources.list.d/docker.sources

docker-ce:
  pkg.installed:
    - version: {{ salt.pillar.get("docker:version", "latest") }}

docker-compose:
  pip.installed:
    - version: {{ salt.pillar.get("docker-compose:version", "latest") }}

/etc/docker-compose:
  file.directory:
    - user: root
    - group: root
    - mode: 755
