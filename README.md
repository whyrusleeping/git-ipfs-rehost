# git-ipfs-rehost

A way to statically host your git repos in ipfs. For now, these are read only.

## Install

```
git clone https://github.com/whyrusleeping/git-ipfs-rehost
cd git-ipfs-rehost
cp git-ipfs-rehost /usr/local/bin/git-ipfs-rehost
```

## Usage

It's as easy as:

```sh
git-ipfs-rehost http://github.com/user/repo
```

### Publish to IPNS (updatable)

Publishing a repository to IPNS makes it possible to continue to update the same mirror, with new commits. This allows the creation of uncensorable _and_ updatable `git` mirrors.

First generate a keypair, which will be the identity of the IPNS name.

```shell
ipfs key gen --type=rsa --size=2048 youtube-dl
```

Then run this script as such:

```
./git-ipfs-rehost https://github.com/l1ving/youtube-dl.git --key youtube-dl
```
