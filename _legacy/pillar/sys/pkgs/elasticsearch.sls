{% if salt.match.glob('itel*') %}
elasticsearch:
    plugins: ['???']
    cluster_name: 'resistance-report'
{% endif %}
