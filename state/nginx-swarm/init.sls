include:
  - swarm

nginx_swarm_host_files:
  file.recurse:
    - name: /volumes/nginx/conf
    - source: salt://{{ slspath }}/configs/
    - makedirs: true
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - clean: false

nginx_swarm_generic_includes:
  file.recurse:
    - name: /volumes/nginx/conf
    - source: salt://nginx/configs/include/
    - makedirs: true
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - clean: false

nginx_swarm_certs:
  file.recurse:
    - name: /volumes/nginx/certs
    - source: salt://nginx/certs/
    - makedirs: true
    - user: root
    - group: root
    - dir_mode: 700
    - file_mode: 600
    - clean: false
    - show_changes: false

/volumes/swarm-files/nginx.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
