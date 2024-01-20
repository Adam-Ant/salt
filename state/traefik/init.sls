include:
  - swarm
  - .network

traefik_config_files:
  file.recurse:
    - name: /volumes/traefik
    - source: salt://{{ slspath }}/config/
    - makedirs: true
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - clean: false
    - template: jinja
    - context: {{ pillar.traefik | json }}

/volumes/swarm-files/traefik.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml.jinja
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
    - template: jinja
    - context: {{ pillar.traefik | json }}