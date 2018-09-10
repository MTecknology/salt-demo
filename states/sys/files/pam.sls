{% for pamconf in ['sshd', 'su', 'sudo'] %}
/etc/pam.d/{{ pamconf }}:
  file.managed:
    - source: salt://etc/pam.d/{{ pamconf }}
    - template: jinja
{% endfor %}
