{{ saltenv }}:
  '*':
    - users
  'web.spritsail.io':
    - gitea
    - imageinfo
    - teamspeak3
    - wekan
    - arg-updater
    - drone
    - bungeecord
  'DockerGames.lan':
    - minecraft-creative
