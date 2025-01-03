include:
- swarm
- traefik.network

home-assistant-directories:
  file.directory:
    - makedirs: true
    - user: root
    - group: root
    - names:
      - /volumes/ha/hass
      - /volumes/ha/zigbee
      - /volumes/ha/piper
      - /volumes/ha/whisper

/volumes/swarm-files/ha.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-swarm.yaml.jinja
    - makedirs: true
    - mode: 644
    - dirmode: 755
    - user: root
    - group: root
    - template: jinja
    - context: {{ pillar.global | json }}

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

/volumes/restic-targets/ha.yaml:
  file.managed:
    - source: salt://{{ slspath }}/backup.yaml
    - mode: 644
    - user: root
    - group: root

