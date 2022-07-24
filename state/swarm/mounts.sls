include:
  - docker

{% if grains['osarch'] == 'arm64' %}
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
{% endif %}

/tmp:
  mount.mounted:
    - device: tmpfs
    - fstype: tmpfs
    - ops: rw,mode=1777,size=4g


/volumes:
  mount.mounted:
    - device: 192.168.1.2:/mnt/vm/services
    - fstype: nfs
    - mkmnt: True
    - ops: rw
    - require:
      - pkg: nfs-common

/mnt/media:
  mount.mounted:
    - device: 192.168.1.3:/mnt/user/media
    - fstype: nfs
    - mkmnt: True
    - ops: rw
    - require:
      - pkg: nfs-common

/volumes/swarm-files:
  file.directory:
    - user: root
    - group: root
    - dirmode: 755
    - file_mode: 600
    - require:
      - mount: /volumes

