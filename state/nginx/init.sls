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
    - clean: False

nginx_generic_includes:
  file.recurse:
    - name: /volumes/web/conf
    - source: salt://{{ slspath }}/configs/include/
    - makedirs: true
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - clean: False

nginx_certs:
  file.recurse:
    - name: /volumes/web/certs
    - source: salt://{{ slspath }}/certs/
    - makedirs: true
    - user: root
    - group: root
    - dir_mode: 700
    - file_mode: 600
    - clean: False

/etc/docker-compose/nginx/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml.jinja
    - makedirs: true
    - user: root
    - group: root
    - mode: 600
    - dirmode: 700
    - template: jinja
  dockercompose.up:
    - name: /etc/docker-compose/nginx/docker-compose.yaml
    - watch:
      - file: nginx_host_files
      - file: nginx_generic_includes
    - require:
      - file: /etc/docker-compose/nginx/docker-compose.yaml
      - sls: docker
