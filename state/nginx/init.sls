include:
  - docker

nginx_host_files:
  file.recurse:
    - name: /volumes/web/conf
    - source: salt://{{ slspath }}/configs/hosts/{{ grains.id }}/
    - makedirs: true
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - clean: false

nginx_generic_includes:
  file.recurse:
    - name: /volumes/web/conf
    - source: salt://{{ slspath }}/configs/include/
    - makedirs: true
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - clean: false

nginx_certs:
  file.recurse:
    - name: /volumes/web/certs
    - source: salt://{{ slspath }}/certs/
    - makedirs: true
    - user: root
    - group: root
    - dir_mode: 700
    - file_mode: 600
    - clean: false
    - show_changes: false

/etc/docker-compose/nginx/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml.jinja
    - template: jinja
    - context:
        bind_ip: {{ salt.pillar.get('nginx:bind_ip', '0.0.0.0') | json }}
        extra_binds: {{ salt.pillar.get('nginx:extra_binds', []) | json }}
    - makedirs: true
    - user: root
    - group: root
    - mode: 600
    - dirmode: 700

nginx:
  dockercompose.up:
    - name: /etc/docker-compose/nginx/docker-compose.yaml
    - watch:
      - file: nginx_host_files
      - file: nginx_generic_includes
      - file: nginx_certs
    - require:
      - file: /etc/docker-compose/nginx/docker-compose.yaml
      - sls: docker
