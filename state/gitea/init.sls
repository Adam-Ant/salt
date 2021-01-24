include:
- docker
- nginx

{%- set uid = 358 %}

/volumes/gitea:
  file.directory:
    - user: {{ uid }}
    - group: {{ uid }}
    - mode: 755

/etc/docker-compose/gitea/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml.jinja
    - template: jinja
    - context:
        uid: {{ uid }}
        bind_ip: {{ pillar.gitea.bind_ip }}
        secret_key: {{ pillar.gitea.secret_key }}
    - makedirs: true
    - user: root
    - group: root
    - mode: 600
    - dirmode: 700

gitea:
  dockercompose.up:
    - name: /etc/docker-compose/gitea/docker-compose.yaml
    - require:
      - file: /etc/docker-compose/gitea/docker-compose.yaml
      - dockercompose: nginx
      - sls: docker
