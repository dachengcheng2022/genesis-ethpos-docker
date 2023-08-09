#!/bin/bash
set -e

if [ ! -f "${DATA_DIR}/genesis.ssz" ]; then
  #config
  echo "init consensus config"
  rm -rf ${DATA_DIR}/*
  cp /etc/genesis.ssz ${DATA_DIR}
  cp /etc/config.yml ${DATA_DIR}
  cp /etc/jwtsecret ${DATA_DIR}
fi

beacon-chain \
  --datadir=${DATA_DIR} \
  --min-sync-peers=0 \
  --genesis-state=${DATA_DIR}/genesis.ssz \
  --bootstrap-node= \
  --chain-config-file=${DATA_DIR}/config.yml \
  --config-file=${DATA_DIR}/config.yml \
  --chain-id=32382 \
  --execution-endpoint=http://eth:8551 \
  --accept-terms-of-use \
  --jwt-secret=${DATA_DIR}/jwtsecret \
  --contract-deployment-block=0 \
  --suggested-fee-recipient=0x123463a4b065722e99115d6c222f267d9cabb524