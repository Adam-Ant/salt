include:
- swarm

/volumes/beets:
  file.directory:
    - makedirs: true
    - user: root
    - group: root
    - mode: 0755

/volumes/beets/config.yaml:
  file.managed:
    - source: salt://{{ slspath }}/config.yaml
    - makedirs: true
    - mode: 0644
    - dirmode: 0755
    - user: root
    - group: root

/volumes/beets/discogs_token.json:
  file.serialize:
    - dataset_pillar: beets:discogs
    - serializer: json
    - user: root
    - group: root
    - mode: 0700


/volumes/swarm-files/beets.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml
    - makedirs: true
    - mode: 0644
    - dirmode: 0755
    - user: root
    - group: root
