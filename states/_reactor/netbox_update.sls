#!py

import hashlib
import hmac
import json

def schedule():
    action = data['data'].get('action', {})
    host = data['data'].get('host', '')
    node = data['data'].get('node', '')
    src = data['id']

    jdata = data['data'].get('data', '{}')

    with open('/tmp/nb', 'w+') as fh:
        from import pprint
        fh.write(pprint(jdata))
    return {}

    #if src.startswith('prd-pubweb') and node:
    #    return {'schedule_saltcloud': {
    #        "runner.state.orchestrate": [
    #            {"args": [
    #                {"mods": "_orchestrate.add_node"}, 
    #            ]}
    #        ]
    #    }}


#    sig = bottle.request.headers.get('X-Hook-Signature', '') 
#    vfy = hmac.new(
#            key=_read('tabkey'),
#            msg=bottle.request.body.read(),
#            digestmod=hashlib.sha512).hexdigest()
