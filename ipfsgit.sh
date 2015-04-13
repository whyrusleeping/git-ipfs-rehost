#!/bin/sh

dir=`mktemp -d`
repo=$dir/tohost
echo rehosting $1
git clone --bare $1 $repo
cd $repo && cp objects/pack/*.pack . && \
	git unpack-objects < ./*.pack && \
	rm ./*.pack

cd $repo && git update-server-info

hash=`ipfs add -q -r $repo | tail -n1`
echo hosted at http://gateway.ipfs.io/ipfs/$hash

