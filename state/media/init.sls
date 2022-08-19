include:
- swarm
- nginx-swarm

{% set uidPairs = {
  'organizr': 'root',
  'nzbget':   901,
  'prowlarr': 911,
  'sonarr':   921,
  'radarr':   922,
  'lidarr':   923,
  'tautulli': 951
} %}


{% for file, uid in uidPairs.items() %}
/volumes/media/{{file}}:
  file.directory:
    - makedirs: true
    - user: {{ uid }}
    - group: {{ uid }}
    - recurse:
      - user
      - group
{% endfor %}

/volumes/swarm-files/media.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
