libpam-google-authenticator:
  pkg.installed:
    - require_in:
      - file: /etc/ssh/sshd_config
      {% for pamconf in ['sshd', 'su', 'sudo'] %}
      - file: /etc/pam.d/{{ pamconf }}
      {% endfor %}
