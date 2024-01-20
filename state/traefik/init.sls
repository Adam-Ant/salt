include:
  - swarm
  - .network

traefik_config_files:
  file.recurse:
    - name: /volumes/traefik/config
    - source: salt://{{ slspath }}/config/
    - makedirs: true
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - clean: false
    - template: jinja
    - context: {{ pillar.traefik | json }}

traefik_certs:
  file.recurse:
    - name: /volumes/traefik/certs
    - source: salt://nginx/certs/
    - makedirs: true
    - user: root
    - group: root
    - dir_mode: 700
    - file_mode: 600
    - clean: false
    - show_changes: false

/volumes/swarm-files/traefik.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
