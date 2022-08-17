#/bin/bash -x

source ~/.nvm/nvm.sh

GODEBUG="netdns=go"

COMMIT_HASH="${COMMIT:-main}"
IPFS_BIN=/usr/local/bin/ifps

## Download IPFS binary
if [[ ! -f "$IPFS_BIN" ]]; then
    wget https://dist-ipfs-tech.ipns.dweb.link/kubo/v0.14.0/kubo_v0.14.0_linux-amd64.tar.gz -O kubo.tar.gz
    tar -xzvf kubo.tar.gz
    kubo/install.sh
    rm kubo.tar.gz
    rm -rf kubo
fi

[ ! -d "./repo" ] && git clone ${REPO} repo

cd repo
git checkout ${COMMIT_HASH}

## TODO: CHECK THE COMMIT HASH
# CURRENT_HASH=$(git rev-parse HEAD)
# [${CURRENT_HASH} != ${COMMIT_HASH} ] 

## Upload to IPFS
git update-server-info
mv .git/objects/pack/*.pack .
git unpack-objects < *.pack
rm -f *.pack .git/objects/pack/*
ipfs --api=/dns/ipfs.dappnode/tcp/5001 add -r . --quiet | tee ../listHashes

REPO_IPFS_HASH=$(tail -1 ../listHashes)

curl    --connect-timeout 5 \
        --max-time 10 \
        --retry 5 \
        --retry-delay 0 \
        --retry-max-time 40 \
        -X POST "http://my.dappnode/data-send?key=RepoIPFSHash&data=http://ipfs.dappnode:8080/ipfs/${REPO_IPFS_HASH}" \
        || { echo "[ERROR] failed to post IPFS HASH to dappmanager"; }

npm i -g yarn

## Install dependencies
yarn

## Build static
yarn build:static

## Upload the UI to IPFS the 
ipfs --api=/dns/ipfs.dappnode/tcp/5001 add -r out --quiet | tee ../listHashesUI

UI_IPFS_HASH=$(ipfs cid base32 $(tail -1 ../listHashesUI))

curl    --connect-timeout 5 \
        --max-time 10 \
        --retry 5 \
        --retry-delay 0 \
        --retry-max-time 40 \
        -X POST "http://my.dappnode/data-send?key=IPFS_URL&data=http://${UI_IPFS_HASH}.ipfs.ipfs.dappnode:8080/" \
        || { echo "[ERROR] failed to post the UI_IPFS_HASH IPFS to dappmanager"; }

yarn serve:static


