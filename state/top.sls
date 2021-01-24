{{ saltenv }}:
  '*':
    - users
  'web.spritsail.io':
    - gitea
    - imageinfo
    - quotesdb
    - teamspeak3
    - wekan
