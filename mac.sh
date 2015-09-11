#!/bin/sh

cd $(dirname "$0")
ip=$(./ip.sh)

ifconfig | grep $ip -B2 | tr A-Z a-z | sed -e 's/.*ether /x/' -e 's/.*hwaddr /x/' -ne 's/^x//p'
