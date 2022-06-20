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
    - velocity
    - registry
  'DockerGames.lan':
    - minecraft-creative
    - minecraft-archive
  'PiCluster-*.lan':
    - swarm
