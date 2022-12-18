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

/home/{{ name }}/.ssh:
  file.directory:
    - user: {{ name }}
    - mode: "700"
    - require:
      - user: {{ name }}

/home/{{ name }}/.ssh/authorized_keys:
  file.managed:
    - user: {{ name }}
    - mode: "600"
    - contents: {{ user.get('ssh_keys', []) | join("\n") | yaml_encode }}
    - require:
      - file: /home/{{ name }}/.ssh
{%- endfor %}
