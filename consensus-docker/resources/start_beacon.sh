#!/bin/bash
set -e

if [ ! -f "${DATA_DIR}/genesis.ssz" ]; then
  #config
  echo "init consensus config"
  rm -rf ${DATA_DIR}/*
  cp /etc/config.yml ${DATA_DIR}
  cp /etc/jwtsecret ${DATA_DIR}
  prysmctl testnet generate-genesis --num-validators=3 --output-ssz=${DATA_DIR}/genesis.ssz --chain-config-file=${DATA_DIR}/config.yml \
          --geth-genesis-json-in=/etc/genesis.json --geth-genesis-json-out=/execution/genesis.json --fork=capella
fi


beacon-chain \
  --datadir=${DATA_DIR} \
  --min-sync-peers=0 \
  --genesis-state=${DATA_DIR}/genesis.ssz \
  --bootstrap-node= \
  --chain-config-file=${DATA_DIR}/config.yml \
  --config-file=${DATA_DIR}/config.yml \
  --chain-id=32382 \
  --rpc-host=0.0.0.0 \
  --contract-deployment-block=0 \
  --grpc-gateway-host=0.0.0.0 \
  --monitoring-host=0.0.0.0 \
  --execution-endpoint=http://eth:8551 \
  --accept-terms-of-use \
  --jwt-secret=${DATA_DIR}/jwtsecret \
  --contract-deployment-block=0 \
  --suggested-fee-recipient=${VALIDATOR_ADDRESS} \
  --verbosity=debug \
  --peer=${PEER_INFO}