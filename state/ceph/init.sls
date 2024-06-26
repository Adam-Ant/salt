include:
  - docker

{% if grains['oscodename'] != 'bookworm' %}
ceph repo:
  pkgrepo.managed:
    - name: deb https://download.ceph.com/{{ grains.os|lower }}-{{ salt.pillar.get("ceph:version", "quincy") }} {{ salt.pillar.get("ceph:debian_ver", grains.oscodename | lower) }} main
    - file: /etc/apt/sources.list.d/ceph.list
    - key_url: https://download.ceph.com/keys/release.gpg
    - architectures: {{ grains.osarch }}
    - refresh: true
{% endif %}

ceph core packages:
  pkg.latest:
    - pkgs:
      - cephadm
      - ceph-common
    - refresh: True
    - install_recommends: False

cephsvc:
  user.present:
    - shell: /bin/sh
    - home: /home/cephsvc
    - usergroup: true
    - createhome: true
    - system: true

cephsvc ssh key:
  ssh_auth.present:
    - user: cephsvc
    - enc: ssh-rsa
    - name: {{ pillar.ceph.pubkey }}

/etc/sudoers.d/cephsvc:
  file.managed:
    - user: root
    - group: root
    - mode: 440
    - contents: |
        cephsvc  ALL=(ALL)  NOPASSWD:ALL

/etc/ceph/ceph.conf:
  file.managed:
    - source: salt://{{ slspath }}/ceph.conf
    - makedirs: true
    - mode: 440
    - dirmode: 755
    - user: root
    - group: root

/etc/ceph/ceph.keyring:
  file.managed:
    - source: salt://{{ slspath }}/admin.keyring
    - makedirs: true
    - mode: 400
    - dirmode: 755
    - user: root
    - group: root

/volumes:
  mount.mounted:
{% if grains['oscodename'] != 'bookworm' %}
    - device: admin@.swarm_persist=/
    - ops: rw
{% else %}
    - device: 192.168.1.81,192.168.1.82:/
    - ops: rw,name=admin
{% endif %}
    - fstype: ceph
    - mkmnt: True
    - persist: True
    - mount: True
