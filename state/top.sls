{{ saltenv }}:
  '*':
    - users
  'web.spritsail.io':
    - watchtower
    - gitea
    - imageinfo
    - teamspeak3
    - wekan
    - arg-updater
    - drone
    - velocity
    - registry
  'DockerGames.lan':
    - watchtower
    - minecraft-creative
    - minecraft-archive
  'PiCluster-*':
    - swarm
  'Cluster-*':
    - swarm
  'DockerSwarm':
    - swarm
    - home-assistant
    - bitwarden
    - beets
    - media
    - traefik
    - authentik
    - wireguard
    - paperless
