docker_repo:
  pkgrepo.managed:
    - name: deb https://download.docker.com/linux/{{ grains.os|lower }} {{ grains.oscodename }} stable
    - file: /etc/apt/sources.list.d/docker.list
    - key_url: https://download.docker.com/linux/debian/gpg
    - architectures: {{ grains.osarch }}
    - refresh: true

docker-deps:
  pkg.latest:
    - pkgs:
      - gnupg
      - ca-certificates
      - docker-ce-cli
      - python3-pip
    - require:
      - pkgrepo: docker_repo

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
