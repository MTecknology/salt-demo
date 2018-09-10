ssh-user:
  group.present

root:
  user.present:
    - shell: /bin/bash
    - home: /root
    - uid: 0
    - gid: 0
    - password: {{ pillar['root_pass'] }}
    - remove_groups: True

root_sshkeygen:
  cmd.run:
    - name: 'ssh-keygen -f /root/.ssh/id_rsa -t rsa -N ""'
    - unless: 'test -f /root/.ssh/id_rsa.pub'

{% if 'root_gauth' in pillar %}
/root/.google_authenticator:
  file.managed:
    - mode: 400
    - contents: |
        {{ pillar['root_gauth'] }}
        " TOTP_AUTH
{% endif %}


{% if 'root_ssh_keys' in pillar %}
{% for k in pillar['root_ssh_keys'].keys() %}
auth_{{ k }}_rsa:
  file.managed:
    - name: /root/.ssh/id_{{ k }}_rsa
    - contents_pillar: root_ssh_keys:{{ k }}:prv
    - mode: 600
    - require:
      - cmd: root_sshkeygen

auth_{{ k }}_pub:
  file.managed:
    - name: /root/.ssh/id_{{ k }}_rsa.pub
    - contents_pillar: root_ssh_keys:{{ k }}:pub
    - mode: 600
    - require:
      - cmd: root_sshkeygen
{% endfor %}
{% endif %}


{% if 'admins' in pillar %}
{% for user, attr in pillar['admins'].items() %}
{{ user }}:
  group.present:
    - gid: {{ attr['gid'] }}
  user.present:
    - shell: /bin/bash
    - home: /home/{{ user }}
    - uid: {{ attr['uid'] }}
    - gid: {{ attr['gid'] }}
    {% if 'pwd' in attr %}
    - password: {{ attr['pwd'] }}
    {% endif %}
    - optional_groups:
      - ssh-user
    - remove_groups: False
    - require:
      - group: ssh-user
      - group: {{ user }}

{% if 'keys' in attr %}
{{ user }}-ssh:
  ssh_auth.present:
    - user: {{ user }}
    - names: {{ attr['keys'] }}
    - require:
      - group: {{ user }}
{% endif %}

{% if 'gauth_key' in attr %}
/home/{{ user }}/.google_authenticator:
  file.managed:
    - mode: 400
    - user: {{ user }}
    - group: {{ user }}
    - contents: |
        {{ attr['gauth_key'] }}
        " TOTP_AUTH
    - require:
      - group: {{ user }}
{% endif %}

{% endfor %}
{% endif %}

{% if 'local_users' in pillar %}
{% for user, attr in pillar['local_users'].items() %}
{{ user }}:
  group.present:
    - gid: {{ attr['gid'] }}
  user.present:
    - shell: /bin/bash
    - home: /home/{{ user }}
    - uid: {{ attr['uid'] }}
    - gid: {{ attr['gid'] }}
    {% if 'pwd' in attr %}
    - password: {{ attr['pwd'] }}
    {% endif %}
    - optional_groups:
      - ssh-user
    - remove_groups: False
    - require:
      - group: ssh-user
      - group: {{ user }}

{% if 'keys' in attr %}
{{ user }}-ssh:
  ssh_auth.present:
    - user: {{ user }}
    - names: {{ attr['keys'] }}
{% endif %}

{% endfor %}
{% endif %}
