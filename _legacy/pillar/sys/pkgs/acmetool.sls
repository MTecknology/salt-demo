{% if salt.match.glob('itel*') %}
acmetool:
  domains:
    - "intel.resistance.report"

{% elif salt.match.glob('pbin.ngx.cc') %}
acmetool:
  domains:
    - "paste.ngx.cc p.ngx.cc"

{% endif %}
