#!/bin/bash -eux

# chef client
perl -p -i -e 's/localhost/172.16.172.16/g' /etc/chef/client.rb
invoke-rc.d chef-client start
update-rc.d chef-client defaults
