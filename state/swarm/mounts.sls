include:
  - docker

/dev/mmcblk0:
  blockdev.formatted:
    - fs_type: ext4

/var/lib/docker:
  mount.mounted:
    - device: /dev/mmcblk0
    - fstype: ext4
    - mkmnt: True
    - require:
      - blockdev: /dev/mmcblk0
    - watch_in:
      - service: docker


/tmp:
  mount.mounted:
    - device: tmpfs
    - fstype: tmpfs
    - ops: rw,mode=1777,size=4g
