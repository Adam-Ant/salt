{% if grains.oscodename == "bullseye" %}
{% set cephversion = "quincy" %}
{% else %}
{% set cephversion = "reef" %}
{% endif %}

include:
  - docker

ceph repo:
  pkgrepo.managed:
    - name: deb https://download.ceph.com/{{ grains.os | lower }}-{{ cephversion }} {{ grains.oscodename | lower }} main
    - file: /etc/apt/sources.list.d/ceph.list
    - key_url: https://download.ceph.com/keys/release.gpg
    - architectures: {{ grains.osarch }}
    - refresh: true

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
    - device: {{ pillar.ceph.device }}
    - ops: rw
    - fstype: ceph
    - mkmnt: True
    - persist: True
    - mount: True
