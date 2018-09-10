nginx:
  pkg.installed:
    - refresh: True
  service.running:
    - reload: True
    - watch:
      - file: /etc/nginx/ssl/dhparam.pem
      - file: /etc/nginx/sites-enabled/default
      - file: /etc/nginx/conf.d/no-tokens.conf
      - file: /etc/nginx/conf.d/ssl-settings.conf
    - require_in:
      - file: /etc/ferm/ferm.conf

## files

/etc/nginx/ssl:
  file.directory:
    - dir_mode: 700
    - require:
      - pkg: nginx

/srv/webapps:
  file.directory

{% if 'webcerts' in pillar %}
{% for k in pillar['webcerts'].keys() %}
/etc/nginx/ssl/{{ k }}:
  file.managed:
    - contents_pillar: webcerts:{{ k }}
    - require:
      - file: /etc/nginx/ssl
{% endfor %}
{% endif %}

/etc/nginx/conf.d/no-tokens.conf:
  file.managed:
    - contents: |
        server_tokens off;
    - require:
      - pkg: nginx

/etc/nginx/conf.d/ssl-settings.conf:
  file.managed:
    - contents: |
        ssl_session_cache shared:SSL:10m;
        ssl_session_timeout 10m;
        ssl_ciphers 'kEECDH+CHACHA kEECDH+AESGCM HIGH+kEECDH AESGCM 3DES !SRP !PSK !DSS !MD5 !LOW !MEDIUM !aNULL !eNULL !DH !kECDH';
        ssl_stapling on;
        ssl_stapling_verify on;
        ssl_dhparam ssl/dhparam.pem;
        ssl_session_tickets off;
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/default:
  file.absent:
    - require:
      - pkg: nginx

{% for site in pillar.get('nginx_sites', []) %}
/etc/nginx/conf.d/{{ site }}.conf:
  file.managed:
    - source: salt://etc/nginx/conf.d/{{ site }}.conf
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx
{% endfor %}

{% for site in pillar.get('nginx_dirs', []) %}
/srv/webapps/{{ site }}:
  file.recurse:
    - clean: True
    - source: salt://srv/webapps/{{ site }}
    - require:
      - file: /srv/webapps
    - watch_in:
      - service: nginx
{% endfor %}
