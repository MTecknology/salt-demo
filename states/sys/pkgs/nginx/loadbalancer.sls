# Cheap hack... for now
/etc/nginx/loadbalancer.conf:
  file.managed:
    - source: salt://etc/nginx/loadbalancer.conf
    - template: jinja
    - watch_in:
      - service: nginx
