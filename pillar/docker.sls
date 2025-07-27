docker:
  options:
    live-restore: true
    # Put all containers into /docker.slice instead of /system.slice
    cgroup-parent: docker.slice
