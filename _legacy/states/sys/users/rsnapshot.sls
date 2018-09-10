# TODO: Create unique jail for each backed up user.
{% for server, keys in salt['mine.get']('*', 'ssh.user_keys').items() %}
{{ server }}:
  user.present:
    - name: {{ server }}
    - createhome: True
    - optional_groups:
      - ssh-user
    - require:
      - group: ssh-user
  ssh_auth.present:
    - user: {{ server }}
    - names: [ {{ keys['root']['id_rsa.pub'] }} ]

# Ensures the user directory is never readable by others
/home/{{ server }}:
  file.directory:
    - user: {{ server }}
    - group: {{ server }}
    - mode: '0700'
    - require:
      - user: {{ server }}
{% endfor %}
