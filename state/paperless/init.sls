include:
- swarm
- traefik.network

{% set uidPairs = {
  'consume': 1000,
  'data':    1000,
  'export':  1000,
  'media':   1000,
  'redis':   999,
} %}


{% for file, uid in uidPairs.items() %}
/volumes/paperless/{{file}}:
  file.directory:
    - makedirs: true
    - user: {{ uid }}
    - group: {{ uid }}
{% endfor %}

/volumes/swarm-files/paperless.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml.jinja
    - template: jinja
    - context: {{ pillar.paperless | json }}
    - makedirs: true
    - mode: 0600
    - dirmode: 0700
    - user: root
    - group: root

/volumes/restic-targets/paperless.yaml:
  file.managed:
    - source: salt://{{ slspath }}/backup.yaml
    - mode: 644
    - user: root
    - group: root

