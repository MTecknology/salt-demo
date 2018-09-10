{% if salt.match.glob('netbox*.domain.tld') %}
virtualenvs:
  netbox:
    path: /opt/netbox-venv
    requirements: /srv/webapps/netbox/requirements.txt
    require:
      - 'git: git_remote-/srv/webapps/netbox'
    require_in:
      - 'service: uwsgi'
    build_depends:
      - libffi-dev
      - libxml2-dev
      - libxslt1-dev
      - libjpeg-dev
    # NOTE: netbox also requires pyasn1 coreapi openapi_codec simplejson

{% endif %}
