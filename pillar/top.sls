{{ saltenv }}:
  '*':
    - docker
    - secret

{%- if salt['pillar.file_exists']('hosts/' ~ opts.id ~ '.sls') %}
  {{ opts.id }}:
    - hosts.{{ opts.id }}
{%- endif %}
