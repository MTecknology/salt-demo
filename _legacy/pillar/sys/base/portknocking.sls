{% if salt.match.glob('arn-camp01.domain.tld') %}
knock_sequence:
  grants:
    proto: (tcp)
    port: (22)
  authorder:
    - udp/274
    - udp/557
    - tcp/95
    - udp/2148
    - udp/5757
    - tcp/44
    - udp/24448
    - tcp/281

{% elif salt.match.glob('irc00.domain.tld') %}
knock_sequence:
  grants:
    proto: (tcp)
    port: (22)
  authorder:
    - udp/2456
    - tcp/2981
    - tcp/95
    - tcp/281
    - udp/24448
    - tcp/281
    - tcp/44

{% else %}
knock_sequence: False

{% endif %}
