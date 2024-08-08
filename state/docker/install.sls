{% if grains.osmajorrelease < 12 %}
/usr/share/keyrings/docker-archive-keyring.gpg:
  file.managed:
    - source: salt://{{ slspath }}/docker.gpg
    - mode: 644
    - user: root
    - group: root
{% endif %}

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
    - require:
      - file: /etc/apt/sources.list.d/docker.sources

docker-ce:
  pkg.installed:
    - version: {{ salt.pillar.get("docker:version", "latest") }}

docker-compose-plugin:
  pkg.installed:
    - version: {{ salt.pillar.get("docker:version", "latest") }}

/etc/docker-compose:
  file.directory:
    - user: root
    - group: root
    - mode: 755
