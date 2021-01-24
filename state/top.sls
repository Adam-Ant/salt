{{ saltenv }}:
  '*':
    - users
  'web.spritsail.io':
    - drone
    - gitea
    - imageinfo
    - nginx
    - quotesdb
    - teamspeak3
    - watchtower
    - wekan
