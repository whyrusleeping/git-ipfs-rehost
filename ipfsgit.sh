#!/bin/sh
# usage: git-ipfs-rehost <git-repo> [name]
# git-ipfs-rehost - rehost a git repo on ipfs

if [ "$#" -eq 0 ]; then
  echo "usage: $0 <git-repo> [<name>]"
  echo "rehost <git-repo> on ipfs"
  exit 1
fi

name=`basename $1`
if [ "$#" -gt 0 ]; then
  name_tmp=($2);
  name=${name_tmp[0]} # avoid users tricky things.
fi

dir=`mktemp -d -t ipfsgit`
tohost=$dir/tohost
repo=$dir/tohost/$name
echo rehosting $1
git clone --bare $1 $repo

cd $repo && cp objects/pack/*.pack . && \
	git unpack-objects < ./*.pack && \
	rm ./*.pack

cd $repo && git update-server-info

hash=`ipfs add -q -r $tohost | tail -n1`
echo "done\n"
echo repo rehosted at http://gateway.ipfs.io/ipfs/$hash/$name
echo you can clone it with:
echo ""
echo "  git clone http://gateway.ipfs.io/ipfs/$hash/$name"
