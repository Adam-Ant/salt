docker:
  options:
    features: 
      buildkit: true
    live-restore: true
    experimental: true
    # Put all containers into /docker.slice instead of /system.slice
    cgroup-parent: docker.slice
