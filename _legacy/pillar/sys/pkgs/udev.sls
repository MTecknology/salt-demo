udev:
  {% if salt.match.glob('arn-scout*') %}
  rules:
    # Scouts are always raspi devices with a verizon mifi device.
    - 99-vzw-620l.rules
  {% endif %}
