#!/bin/bash -eux

# upload
if [ -d /vagrant/cookbooks/ ]; then
    cd /vagrant/cookbooks
    for x in $(find * -maxdepth 0 -type d); do
        sudo -u vagrant knife cookbook upload $x
    done
fi
if [ -d /vagrant/roles/ ]; then
    cd /vagrant/roles
    for x in $(ls | egrep ".*(rb|json)"); do
        sudo -u vagrant knife role from file $x
    done
fi
