docker:
  options:
    ipv6: true
    ip6tables: true
    fixed-cidr-v6: fd00:d0c:7e4::/48

nginx:
  bind_ip: 51.38.73.115
  extra_binds:
    - "[2001:41d0:801:2000::3d0e]:443:443"
    - "[2001:41d0:801:2000::3d0e]:80:80"

teamspeak3:
  bind_ip: 51.38.73.115

velocity:
  bind_ip: 51.38.73.115
  geyser_port: 19132
