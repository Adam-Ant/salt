include:
  - docker

/dev/mmcblk0:
  blockdev.formatted:
    - fs_type: ext4

/var/lib/docker:
  mount.fstab_present:
    - name: /dev/mmcblk0
    - fs_file: /var/lib/docker
    - fs_vfstype: ext4
    - require:
      - blockdev: /dev/mmcblk0
    - watch_in:
      - service: docker


tmpfs:
  mount.fstab_present:
    - name: tmpfs
    - fs_file: /tmp
    - fs_vfstype: tmpfs
    - fs_mntops: rw,mode=1777,size=4g
