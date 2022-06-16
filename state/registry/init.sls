include:
- docker
- nginx

/volumes/registry/data:
  file.directory:
    - makedirs: true

/etc/docker-compose/registry/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml.jinja
    - template: jinja
    - context: {{ pillar.drone | json }}
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
    - require:
      - sls: docker

/volumes/registry/htpasswd:
  file.managed:
    - makedirs: true
    - user: root
    - group: root
    - mode: 0600
    - contents: |
{%- for entry in pillar.registry.htpasswd.items() %}
        {{ entry }}
{%- endfor %}

registry:
  dockercompose.up:
    - name: /etc/docker-compose/registry/docker-compose.yaml
    - pull: true
    - require:
      - dockercompose: nginx
      - file: /etc/docker-compose/registry/docker-compose.yaml
      - file: /volumes/registry/data
    - watch:
      - file: /volumes/registry/htpasswd

