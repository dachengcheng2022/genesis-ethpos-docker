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

  validator \
  --datadir=${DATA_DIR}/validatordata \
  --accept-terms-of-use \
  --interop-num-validators=64 \
  --interop-start-index=0 \
  --force-clear-db \
  --chain-config-file=${DATA_DIR}/config.yml \
  --config-file=${DATA_DIR}/config.yml