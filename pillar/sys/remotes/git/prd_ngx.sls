git_remotes:
  - remote: https://github.com/ngx/pbin.git
    local: /srv/webapps/ngxpbin
    req_in:
      - "service: nginx"
      - "service: uwsgi"

  - remote: https://github.com/ngx/pubconf.git
    local: /etc/ngx-configs
    req_in:
      - "service: nginx"
