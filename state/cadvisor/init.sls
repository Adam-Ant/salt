include:
  - docker

python3-docker:
  pkg.latest

cadvisor:
  docker_container.running:
    - image: gcr.io/cadvisor/cadvisor
    - command:
      - --listen_ip={{ salt.pillar.get("cadvisor:listen_ip", "localhost") }}
      - --port={{ salt.pillar.get("cadvisor:port", 8080) }}
      - --disable_metrics=percpu,hugetlb,referenced_memory,advtcp,sched
      - --store_container_labels=false
    - devices: /dev/kmsg
    - privileged: true
    - network_mode: host
    - pid_mode: host
    - binds:
      - /:/rootfs:ro
      - /dev/disk/:/dev/disk:ro
      - /sys:/sys:ro
      - /var/lib/docker/:/var/lib/docker:ro
      - /var/run:/var/run:ro
    - restart: on-failure
    - require:
      - sls: docker
      - pkg: python3-docker

