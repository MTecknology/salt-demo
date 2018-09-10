mlustfield_buildsite:
  cmd.wait:
    - name: pelican -s /srv/webapps/mlustfield-site/pelicanconf.py -o /srv/webapps/mlustfield-output -q
    - watch_in:
      - cmd: sphinxsearch-indexer

/srv/uploads:
  file.directory:
    - user: www-data
    - group: www-data
    - dir_mode: 750
