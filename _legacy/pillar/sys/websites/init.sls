{% if salt.match.glob('apt*.domain.tld') %}
nginx_sites: ['apt']
nginx_dirs: ['apt']

{% elif salt.match.glob('boot*.domain.tld') %}
nginx_sites: ['pxeboot']

{% elif salt.match.glob('git.domain.tld') %}
nginx_sites: ['git']

{% elif salt.match.glob('irc.domain.tld') %}
nginx_sites: ['paste-service']

{% elif salt.match.glob('itel.domain.tld') %}
nginx_sites: ['itel']

{% elif salt.match.glob('inalert*') %}
nginx_sites: ['inalert-api']
uwsgi-apps: ['inalert-api']
uwsgi-deps: ['uwsgi-plugin-python', 'python-bottle']

{% elif salt.match.glob('pbin.ngx.cc') %}
nginx_sites: ['ngxpbin']
uwsgi-apps: ['ngxpbin']
uwsgi-deps: ['uwsgi-plugin-python', 'python-bottle', 'python-redis', 'redis-server']

{% elif salt.match.glob('mlweb*') %}
nginx_sites: ['mlustfield-site', 'mlustfield-search', 'ip-service', 'api-mlustfield']
nginx_dirs: ['api-mlustfield']
uwsgi-apps: ['mlustfield-search', 'contact-form', 'api-mlustfield']
uwsgi-deps: ['uwsgi-plugin-python', 'python-bottle', 'python-redis', 'redis-server']

{% elif salt.match.glob('netbox*.domain.tld') %}
nginx_sites: ['netbox']
uwsgi-apps: ['netbox']
uwsgi-deps: ['uwsgi-plugin-python']

{% endif %}
