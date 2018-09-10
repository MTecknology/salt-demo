elasticsearch-deps:
  pkg.installed:
    - pkgs:
      - openjdk-7-jre

elasticsearch:
  pkg.installed:
    - refresh: True
    - require:
      - pkg: elasticsearch-deps
      - pkgrepo: elasticsearch-repo
  service.running:
    - require:
      - pkg: elasticsearch
    - watch:
      - file: /etc/default/elasticsearch
      - file: /etc/elasticsearch/elasticsearch.yml

## files

elasticsearch-repo:
  pkgrepo.managed:
    - humanname: "elastic.co elasticsearch"
    - name: "deb http://apt.domain.tld/elastic stable main"
    - dist: stable
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - key_url: salt://etc/apt/keys/D88E42B4.pub

/etc/default/elasticsearch:
  file.managed:
    - source: salt://etc/default/elasticsearch
    - template: jinja
    - require:
      - pkg: elasticsearch

/etc/elasticsearch/elasticsearch.yml:
  file.managed:
    - source: salt://etc/elasticsearch/elasticsearch.yml
    - template: jinja
    - require:
      - pkg: elasticsearch
