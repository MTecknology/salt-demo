Ingress Intelligence Report
===========================

Pillar Values
-------------

Need to configure these::

    logstash:
        configs: ['ingress.conf']
        patterns: ['ingress_email']
        templates: ['ingress.json']
        imap_user: 'user@domain.tld'
        imap_pass: 'foobar'

    elasticsearch:
        plugins: ['???']
        cluster_name: 'resistance-report'

    nginx_sites: ['itel']

Firewall Rules
--------------

Inbound Rules:

* tcp/80
* tcp/443

Outbound Rules:

* tcp/993
