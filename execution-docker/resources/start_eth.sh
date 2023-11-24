#!/bin/bash
set -e

echo "geth starting "
cp /etc/geth_password.txt ${CONFIG_BASE_DIR}/
cp /etc/jwtsecret ${CONFIG_BASE_DIR}

geth  --datadir ${DATA_DIR} --http --http.api=net,web3,eth,debug,engine,admin \
                     --http.corsdomain=* --http.vhosts=* --http.addr=0.0.0.0   \
                     --syncmode=full --networkid=97823 --nodiscover \
                     --authrpc.jwtsecret=${CONFIG_BASE_DIR}/jwtsecret --authrpc.addr=0.0.0.0 --authrpc.port=8551 --authrpc.vhosts=* \
                     --allow-insecure-unlock  --password=${CONFIG_BASE_DIR}/geth_password.txt \
                     --verbosity=5 --ipcpath=/data-ephemera --nodekey=${CONFIG_BASE_DIR}/enode.key --nat=extip:${EXTIP}

echo "geth starting endding "
