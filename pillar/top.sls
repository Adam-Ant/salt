{{ saltenv }}:
  '*':
    - users
    - docker
    - secret

{%- set id_underscore = opts.id | replace('.', '_') %}
{%- if salt['pillar.file_exists']('hosts/' ~ id_underscore ~ '.sls') %}
  {{ opts.id }}:
    - hosts.{{ id_underscore }}
{%- endif %}
