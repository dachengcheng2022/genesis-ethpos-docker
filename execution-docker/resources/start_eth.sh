#!/bin/bash
set -e

if [ ! -e "${DATA_DIR}/geth" ]; then
  #config
  rm -rf ${DATA_DIR}/*
  geth --datadir ${DATA_DIR} init /etc/genesis.json
  cp /etc/jwtsecret ${DATA_DIR}
fi

geth  --datadir ${DATA_DIR} --http --http.api=net,web3,eth,debug,engine \
                     --http.corsdomain=* --http.vhosts=* --http.addr=0.0.0.0   \
                     --syncmode=full --networkid=32382 --nodiscover \
                     --authrpc.jwtsecret=${DATA_DIR}/jwtsecret --authrpc.addr 0.0.0.0 --authrpc.port 8551 --authrpc.vhosts 0.0.0.0 

