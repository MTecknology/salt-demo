Netbox Deployment
=================

Purpose
-------

Netbox requires special python modules that are not currently in Debian.

Upgrade
-------

::

    source /opt/netbox-venv/bin/activate
    cd /srv/webapps/netbox
    git checkout v2.4.4
    ./upgrade.sh
    service netbox restart

Deployment
----------

Virtual Environment::

    virtualenv -p python3 /opt/netbox-venv
    source /opt/netbox-venv/bin/activate
    pip3 install -r /srv/webapps/netbox/requirements.txt

Create /srv/webapps/netbox/netbox/netbox/configuration.py.

Initial Setup (w/ current netbox bug)::

    source /opt/netbox-venv/bin/activate

    cd /srv/webapps/netbox
    git checkout v2.2.6
    ./upgrade.sh # it will fail
    pip3 install djangorestframework==3.6.4
    python3 netbox/manage.py migrate
    python3 netbox/manage.py collectstatic --no-input

Initial Setup (w/ bug fixed)::

    source /opt/netbox-venv/bin/activate

    cd /srv/webapps/netbox
    git checkout v2.2.6
    ./upgrade.sh

Create Admin User::

    python3 manage.py createsuperuser


To Do
-----

1. Move management of configuration.py to salt.
