#!/bin/bash -ex

# host -> ~/.chef
sudo -u vagrant rsync -r /vagrant/.chef/ ~/.chef/

exit 0
