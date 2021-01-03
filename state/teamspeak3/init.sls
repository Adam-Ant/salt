include:
- docker

/volumes/teamspeak:
  file.directory:
    - makedirs: true

/volumes/teamspeak/query_ip_allowlist.txt:
  file.managed:
    - source: salt://{{ slspath }}/files/query_ip_allowlist.txt
    - user: root
    - group: root
    - require:
      - file: /volumes/teamspeak

/etc/docker-compose/teamspeak3/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml.jinja
    - template: jinja
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
    - context:
        bind_ip: {{ pillar.teamspeak3.bind_ip }}
    - require:
      - sls: docker

/volumes/jts3servermod/config:
  file.recurse:
    - source: salt://{{ slspath }}/files/jts3servermod/
    - template: jinja
    - context: {{ pillar.teamspeak3 | json }}
    - makedirs: true
    - user: root
    - group: root
    - clean: true

teamspeak3:
  dockercompose.up:
    - name: /etc/docker-compose/teamspeak3/docker-compose.yaml
    - require:
      - file: /etc/docker-compose/teamspeak3/docker-compose.yaml
      - file: /volumes/teamspeak/query_ip_allowlist.txt
      - file: /volumes/jts3servermod/config
