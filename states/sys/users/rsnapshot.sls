bkupnode:
  group.present

{% for server, keys in salt.mine.get('*', 'ssh.user_keys').items() %}
{{ server }}:
  user.present:
    - name: {{ server }}
    - createhome: True
    - optional_groups:
      - ssh-user
      - bkupnode
    - require:
      - group: ssh-user
      - group: bkupnode
  ssh_auth.present:
    - user: {{ server }}
    - names: [ {{ keys['root']['id_rsa.pub'] }} ]
    - options:
      - 'command="/usr/bin/rdiff-backup --server"'
      - 'no-port-forwarding'
      - 'no-x11-forwarding'
      - 'no-agent-forwarding'
    - fingerprint_hash_type: md5

# Ensures the user directory is never readable by others
/home/{{ server }}:
  file.directory:
    - user: {{ server }}
    - group: {{ server }}
    - mode: '0700'
    - require:
      - user: {{ server }}
{% endfor %}
