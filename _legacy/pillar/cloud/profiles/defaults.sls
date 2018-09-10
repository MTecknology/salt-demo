{% set defaults = {
    'digitalocean': {
        'image': '8.8 x64',
        'location': 'New York 3',
        'size': '512MB',
        },
    'proxint': {
        'image': 'slowdisk:vztmpl/debian-8.0_Lustfield.tar.gz',
        'storage': 'slowdisk',
        'disk_size': '8',
        'type': 'lxc',
        'host': 'prox1',
        'onboot': True,
        'swap': 0,
        'cpu': 2,
        'mem': 256,
        }
    } %}
