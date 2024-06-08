include:
- swarm
- traefik.network

{% set uidPairs = {
  'certs': 'root',
  'custom-templates': 'root',
  'media': '1000',
  'postgres': 70,
  'redis': 999,
  'templates': 'root'
} %}


{% for file, uid in uidPairs.items() %}
/volumes/authentik/{{file}}:
  file.directory:
    - makedirs: true
    - user: {{ uid }}
    - group: {{ uid }}
{% endfor %}

/volumes/swarm-files/authentik.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml.jinja
    - template: jinja
    - context: {{ pillar.authentik | json }}
    - makedirs: true
    - mode: 0600
    - dirmode: 0700
    - user: root
    - group: root
