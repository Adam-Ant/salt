include:
- docker
- ceph

/etc/restic/profiles.yaml:
  file.managed:
    - source: salt://{{ slspath }}/profiles.yaml.jinja
    - context: {{ pillar.restic | json }}
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: true
    - dir_mode: 755

/etc/restic/key:
  file.managed:
    - contents_pillar: restic:enc_key
    - user: root
    - group: root
    - mode: 600

/etc/restic/includes.d:
  file.recurse:
    - source: salt://{{ slspath }}/includes.d #in secrets
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644

/etc/docker-compose/restic/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml.jinja
    - context: {{ pillar.restic | json }}
    - template: jinja
    - makedirs: true
    - user: root
    - group: root
    - mode: 644
    - dirmode: 755

restic:
  dockercompose.up:
    - name: /etc/docker-compose/restic/docker-compose.yaml
    - require:
      - file: /etc/docker-compose/restic/docker-compose.yaml
      - sls: docker
      - sls: ceph
