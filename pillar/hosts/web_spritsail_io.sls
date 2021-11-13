docker:
  options:
    ipv6: true
    ip6tables: true
    fixed-cidr-v6: fd00:d0c:7e4::/48

nginx:
  bind_ip: 54.36.224.198
  extra_binds:
    - 51.68.203.254:443:444

teamspeak3:
  bind_ip: 51.38.73.115

bungeecord:
  bind_ip: 51.38.73.115
