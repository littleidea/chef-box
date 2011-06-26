#!/bin/bash -ex

# chef client
invoke-rc.d chef-client start
update-rc.d chef-client defaults
