include:
  - sys.base.portknocking

{% if salt.match.glob('irc.domain.tld') or
      salt.match.glob('arn*') %}
ferm_rules:
  inbound:
    # ACCEPT | Home
    - proto tcp dport ssh saddr 43.2.0.0/16 ACCEPT;
    - proto tcp dport ssh saddr 12.10.2.0/24 ACCEPT;
    # ACCEPT | Home
    - proto tcp dport ssh saddr 2001:450:18fe::/48 ACCEPT;
    # ACCEPT | Airport: SFO
    - proto tcp dport ssh saddr 56.102.49.0/24 ACCEPT;
    # ACCEPT | Airport: DFW
    - proto tcp dport ssh saddr 64.18.0.0/16 ACCEPT;
    - proto tcp dport ssh saddr 69.33.0.0/16 ACCEPT;
    # ACCEPT | Hotel: San Jose, CA
    - proto tcp dport ssh saddr 29.37.0.0/16 ACCEPT;
    - proto tcp dport ssh saddr 102.207.0.0/16 ACCEPT;
    # DROP | aggressive content scraping
    - proto tcp saddr 185.25.22.178 DROP;

{% elif salt.match.glob('pbin.ngx.cc') %}
ferm_rules:
  inbound:
    # ACCEPT | Home
    - proto tcp dport ssh saddr 43.2.0.0/16 ACCEPT;
    - proto tcp dport ssh saddr 12.10.2.0/24 ACCEPT;
    # ACCEPT | Home
    - proto tcp dport ssh saddr 2001:450:18fe::/48 ACCEPT;
    # ACCEPT | Hotel: San Jose, CA
    - proto tcp dport ssh saddr 29.37.0.0/16 ACCEPT;
    - proto tcp dport ssh saddr 102.207.0.0/16 ACCEPT;

{% elif 'manufacturer' in grains and grains['manufacturer'] == 'DigitalOcean' %}
ferm_rules:
  inbound:
    # ACCEPT | Home
    - proto tcp dport ssh saddr 43.2.0.0/16 ACCEPT;
    - proto tcp dport ssh saddr 12.10.2.0/24 ACCEPT;
    # ACCEPT | Home
    - proto tcp dport ssh saddr 2001:450:18fe::/48 ACCEPT;

{% endif %}
