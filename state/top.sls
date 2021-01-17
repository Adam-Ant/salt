{{ saltenv }}:
  '*':
    - users
  'web.spritsail.io':
    - imageinfo
    - quotesdb
    - teamspeak3
    - wekan
