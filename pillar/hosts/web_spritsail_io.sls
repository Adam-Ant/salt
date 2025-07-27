docker:
  options:
    ipv6: true
    default-network-opts:
      bridge:
        com.docker.network.enable_ipv4: "true"
        com.docker.network.enable_ipv6: "true"

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
