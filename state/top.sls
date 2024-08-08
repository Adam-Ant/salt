{{ saltenv }}:
  '*':
    - users
    - base-pkgs
  'web.spritsail.io':
    - watchtower
    - gitea
    - teamspeak3
    - wekan
    - arg-updater
    - drone
    - velocity
    - registry
    - matrix
    - metrics
  'DockerGames.lan':
    - watchtower
    - minecraft-creative
    - minecraft-archive
  'PiCluster-*':
    - swarm
  'Cluster-*':
    - swarm
    - ceph
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
    - guacamole
    - tgvideobot
    - homepage
    - epicgames-free
    - podfetch
    - mealie
    - shepherd
  'oracledronerunner':
    - drone-runner
  'ceph.lan':
    - ceph
  'ValheimServer':
    - ceph
    - watchtower
  'DockerOps.lan':
    - ceph
