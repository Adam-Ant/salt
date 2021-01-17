include:
  - docker

/volumes/github-notify:
  file.directory:
    - makedirs: true

/volumes/github-notify/config.json:
  file.serialize:
    - mode: 0600
    - serializer: json
    - require:
      - file: /volumes/github-notify
    - dataset:
        github:
          token: {{ pillar["github-notify"].github_token }}
          url: https://api.github.com/graphql
        mongodb:
          name: github-releases
          url: mongodb://mongo:27017/
        telegram:
          token: {{ pillar["github-notify"].telegram_token }}
          proxy: ""
        adminUserName: Adam_Ant
        app:
          logs: ./bot.log
          restartRate: 180
          updateInterval: 300

/volumes/github-notify/mongo:
  file.directory:
    - user: 999
    - group: 999
    - mode: 0700
    - require:
      - file: /volumes/github-notify

/etc/docker-compose/github-notify/docker-compose.yaml:
  file.managed:
    - source: salt://{{ slspath }}/docker-compose.yaml
    - makedirs: true
    - user: root
    - group: root
    - mode: 644

github-notify:
  dockercompose.up:
    - name: /etc/docker-compose/github-notify/docker-compose.yaml
    - require:
      - file: /etc/docker-compose/github-notify/docker-compose.yaml
      - sls: docker
    - watch:
      - file: /volumes/github-notify/config.json
