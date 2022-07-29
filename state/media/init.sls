include:
- swarm
- nginx-swarm

home-assistant-directories:
  file.directory:
    - makedirs: true
    - user: root
    - group: root
    - names:
      - /volumes/media/organizr
      - /volumes/media/nzbget
      - /volumes/media/hydra
      - /volumes/media/sonarr
      - /volumes/media/radarr
      - /volumes/media/lidarr
      - /volumes/media/tautulli
      - /volumes/media/plex
      - /volumes/media/jellyfin

/volumes/swarm-files/media.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root

/volumes/ha/mosquitto/config/credentials:
  file.managed:
    - makedirs: true
    - user: 1883
    - group: 1883
    - mode: 0600
    - contents: |
{%- for entry in salt['pillar.get']('home-assistant:mosquitto:creds') %}
        {{ entry }}
{%- endfor %}
    - require:
      - file: home-assistant-directories
