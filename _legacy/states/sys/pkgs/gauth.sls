libpam-google-authenticator:
  pkg.installed:
    - require_in:
      - file: /etc/ssh/sshd_config
      {% for pamconf in ['sshd', 'su', 'sudo'] %}
      - file: /etc/pam.d/{{ pamconf }}
      {% endfor %}

## files

{% if grains['id'].startswith('oob-scout') %}

{% for admin_user in salt['pillar.get']('admins', {}).keys() %}

  {% for hostgroup in ['oob-camp*', 'axis*'] %}
    {% for server, keys in salt['mine.get'](hostgroup, 'ssh.user_keys').items() %}
      {% for user, key in keys.items() %}
ssh_gauth_{{ admin_user }}_{{ server }}_{{ user }}:
  ssh_auth.present:
    - user: {{ admin_user }}
    - names: [ {{ key['id_rsa.pub'] }} ]
    - require:
      - user: {{ admin_user }}
      {% endfor %}
    {% endfor %}
  {% endfor %}

{% endfor %}

{% endif %}
