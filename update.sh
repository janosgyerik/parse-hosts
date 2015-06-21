#!/bin/bash

cd $(dirname "$0")
. ./config.sh
. ./functions.sh

objectId=$(get_host_by_name $(hostname) | ./extract-objectId.py)

if test "$objectId"; then
    update_host $(hostname) $(./ip.sh) $objectId
else
    create_host $(hostname) $(./ip.sh)
fi
