include:
  - sys.pkgs.git-client
  - sys.pkgs.pip-client
  - sys.pkgs.sphinxsearch
  - sys.pkgs.uwsgi
  - sys.pkgs.nginx

mlustfield-site-deps:
  pkg.installed:
    - pkgs:
      - python-pelican
      - python-bs4

mlustfield-search-deps:
  pkg.installed:
    - pkgs:
      - python-bottle
      - python-mysqldb
      - python-sqlalchemy
    - watch_in:
      - service: uwsgi

mlustfield-search-sqlalchemy:
  pip.installed:
    - name: bottle-sqlalchemy
    - require:
      - pkg: mlustfield-search-deps
      - pkg: pip-client
    - require_in:
      - service: uwsgi


mlustfield-search-sphinxalchemy:
  pip.installed:
    - name: sphinxalchemy
    - require:
      - pkg: mlustfield-search-deps
      - pkg: pip-client
    - watch_in:
      - service: uwsgi

mlustfield-site:
  git.latest:
    - name: user@git.domain.tld:pubweb/mlustfield-site.git
    - target: /srv/webapps/mlustfield-site
    - identity: /root/.ssh/id_pubweb_rsa
    - depth: 5
    - force_clone: True
    - force_reset: True
    - require:
      - file: auth_pubweb_rsa
      - pkg: git-client
      - pkg: mlustfield-site-deps

mlustfield-search:
  git.latest:
    - name: user@git.domain.tld:pubweb/mlustfield-search.git
    - target: /srv/webapps/mlustfield-search
    - identity: /root/.ssh/id_pubweb_rsa
    - depth: 5
    - force_clone: True
    - force_reset: True
    - require:
      - file: auth_pubweb_rsa
      - pkg: git-client
      - pkg: mlustfield-search-deps
      - pip: mlustfield-search-sphinxalchemy
      - pip: mlustfield-search-sqlalchemy
      - cmd: mlustfield_buildsite
    - watch_in:
      - service: uwsgi

mlustfield_buildsite:
  cmd.wait:
    - name: pelican -s /srv/webapps/mlustfield-site/pelicanconf.py -o /srv/webapps/mlustfield-output -q
    - watch:
      - git: mlustfield-site
    - watch_in:
      - cmd: sphinxsearch-indexer
      - service: uwsgi
    - require:
      - git: mlustfield-site

contact-form:
  git.latest:
    - name: user@git.domain.tld:pubweb/contact-form.git
    - target: /srv/webapps/contact-form
    - identity: /root/.ssh/id_pubweb_rsa
    - depth: 5
    - force_clone: True
    - force_reset: False
    - require:
      - file: auth_pubweb_rsa
      - pkg: git-client
    - watch_in:
      - service: uwsgi
