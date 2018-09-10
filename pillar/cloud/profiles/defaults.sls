{% set defaults = {
    'do': {
        'location': 'New York 3',
        'size': '512MB',
        },
    'proxint': {
        'storage': 'slowdisk',
        'disk_size': '8',
        'type': 'lxc',
        'onboot': 1,
        'swap': 0,
        'cpu': 2,
        'memory': 512,
        'ostype': 'debian'
        }
    } %}
