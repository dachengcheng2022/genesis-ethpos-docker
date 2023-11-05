#!/bin/bash
set -e

if [ ! -e "${DATA_DIR}/geth" ]; then
  #config
  # rm -rf ${DATA_DIR}/*
  geth --datadir ${DATA_DIR} init /execution/genesis.json
  cp /etc/jwtsecret ${DATA_DIR}
  cp /etc/UTC--2022-08-19T17-38-31.257380510Z--123463a4b065722e99115d6c222f267d9cabb524 ${DATA_DIR}/keystore/
  cp /etc/UTC--2023-08-19T04-56-23.233940000Z--630486d226bd0cc219623c79b54b9f8d01d1b95c ${DATA_DIR}/keystore/
  cp /etc/UTC--2023-08-19T06-43-03.349924000Z--31dac3e0045b99d519d55644a3070bc7173af471 ${DATA_DIR}/keystore/
  cp /etc/geth_password.txt ${DATA_DIR}/
fi

# 0x123463a4b065722e99115d6c222f267d9cabb524
geth  --datadir ${DATA_DIR} --http --http.api=net,web3,eth,debug,engine,admin \
                     --http.corsdomain=* --http.vhosts=* --http.addr=0.0.0.0   \
                     --syncmode=full --networkid=32382 --nodiscover \
                     --authrpc.jwtsecret=${DATA_DIR}/jwtsecret --authrpc.addr=0.0.0.0 --authrpc.port=8551 --authrpc.vhosts=* \
                     --allow-insecure-unlock  --unlock=${VALIDATOR_ADDRESS} --password=${DATA_DIR}/geth_password.txt \
                     --verbosity=5 --ipcpath=/data-ephemera
