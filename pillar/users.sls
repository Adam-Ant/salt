{%- set sudo_group = 'sudo' if grains.os|lower == 'debian' else 'wheel' %}
{%- set admin_groups = [sudo_group, 'adm'] %}
{%- set optional_groups = ['docker'] %}
{%- if grains.init == 'systemd' %}
  {%- do optional_groups.append('systemd-journal') %}
{%- endif %}

users:
  adam:
    groups: {{ admin_groups | json }}
    opt_groups: {{ optional_groups | json }}
  
  frebib:
    groups: {{ admin_groups | json }}
    opt_groups: {{ optional_groups | json }}
