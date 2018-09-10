{% from 'sys/pkgs/sphinxsearch/defaults.sls' import conf with context -%}
sphinxsearch:
  pkg.installed:
    - name: sphinxsearch
  service.running:
    - enable: True
    - watch:
      - file: /etc/sphinxsearch/sphinx.conf
    - require:
      - pkg: sphinxsearch
      - file: /etc/sphinxsearch/sphinx.conf
      - cmd: sphinxsearch-indexer

sphinxsearch-indexer:
  cmd.wait:
    - name: /usr/bin/indexer --all --noprogress --quiet --rotate
    - watch:
      - file: /etc/sphinxsearch/sphinx.conf

## files

{% if conf['sphinxconf'] %}
/etc/sphinxsearch/sphinx.conf:
  file.managed:
    - source: salt://etc/sphinxsearch/sphinx.conf%%{{ conf['sphinxconf'] }}
    - require:
      - pkg: sphinxsearch
{% endif %}
