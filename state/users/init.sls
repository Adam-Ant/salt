{%- for name, user in pillar.get('users', {}).items() %}
{{ name | json }}:
  user.present:
    - usergroup: true
    - createhome: true
    - shell: {{ user.get('shell', '/bin/bash') }}
    - groups: {{ user.get('groups', []) | json }}
    - optional_groups: {{ user.get('opt_groups', []) | json }}
    {%- if user.password is defined %}
    - password: {{ user.password | json }}
    {%- endif %}
  ssh_auth.manage:
    - user: {{ name }}
    - ssh_keys: {{ user.get('ssh_keys', [])|json }}
{%- endfor %}
