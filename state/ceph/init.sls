include:
  - docker

ceph_repo:
  pkgrepo.managed:
    - name: deb https://download.ceph.com/{{ grains.os|lower }}-{{ salt.pillar.get("ceph:version", "quincy") }} {{ salt.pillar.get("ceph:debian_ver", grains.oscodename | lower) }} main
    - file: /etc/apt/sources.list.d/ceph.list
    - key_url: https://download.ceph.com/keys/release.gpg
    - architectures: {{ grains.osarch }}
    - refresh: true

cephadm:
  pkg.latest:
    - refresh: True

cephsvc:
  user.present:
    - shell: /bin/sh
    - home: /home/cephsvc
    - usergroup: true
    - createhome: true
    - system: true

/etc/sudoers.d/cephsvc:
  file.managed:
    - user: root
    - group: root
    - mode: 440
    - contents: |
        cephsvc  ALL=(ALL)  NOPASSWD:ALL


