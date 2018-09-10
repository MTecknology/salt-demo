/etc/gai.conf:
  file.uncomment:
    - regex: "precedence ::ffff:0:0/96  100"
    - backup: False
