include:
- docker
- nginx

/volumes/drone:
  file.directory:
    - makedirs: true

/etc/docker-compose/drone/docker-compose.yaml:
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

/volumes/drone-notify/notify.conf:
  file.managed:
    - makedirs: true
    - contents: |
        [main]
        token = {{ pillar.drone.notify.token }}

        [channels]
{%- for name, id in pillar.drone.notify.channels.items() %}
        {{ name }}: {{ id }}
{%- endfor %}

drone:
  dockercompose.up:
    - name: /etc/docker-compose/drone/docker-compose.yaml
    - pull: true
    - require:
      - dockercompose: nginx
      - file: /etc/docker-compose/drone/docker-compose.yaml
      - file: /volumes/drone
    - watch:
      - file: /volumes/drone-notify/notify.conf

