#!/bin/sh

dir=`mktemp -d`
clonelog=`mktemp`
repo=$dir/tohost
echo Rehosting repo at \'$1\'.
git clone --bare $1 $repo 2> $clonelog
if [ $? -ne 0 ]; then
	cat $clonelog
	exit -1
fi

cd $repo && cp objects/pack/*.pack . 2> /dev/null && \
	git unpack-objects < ./*.pack && \
	rm ./*.pack

cd $repo && git update-server-info

hash=`ipfs add -q -r $repo | tail -n1`
echo hosted at http://gateway.ipfs.io/ipfs/$hash
echo try it out: 'git clone http://gateway.ipfs.io/ipfs/$hash'
