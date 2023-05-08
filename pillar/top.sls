{{ saltenv }}:
  '*':
    - users
    - docker
    - secret
    - ceph
    - guacamole

  'PiCluster-*':
    - swarm

{%- set id_underscore = opts.id | replace('.', '_') %}
{%- if salt['pillar.file_exists']('hosts/' ~ id_underscore ~ '.sls') %}
  {{ opts.id }}:
    - hosts.{{ id_underscore }}
{%- endif %}
