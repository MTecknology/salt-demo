sphinxsearch:
  pkg.installed:
    - require:
      - pkgrepo: mtrepo
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

{% if 'sphinxconf' in pillar %}
/etc/sphinxsearch/sphinx.conf:
  file.managed:
    - source: salt://etc/sphinxsearch/sphinx.conf%%{{ pillar['sphinxconf'] }}
    - require:
      - pkg: sphinxsearch
{% endif %}
