#!/bin/bash
set -e

echo "beacon starting "

beacon-chain \
  --datadir=${DATA_DIR} \
  --min-sync-peers=0 \
  --genesis-state=${CONFIG_BASE_DIR}/genesis.ssz \
  --bootstrap-node= \
  --chain-config-file=/config.yml \
  --config-file=/config.yml \
  --chain-id=97823 \
  --rpc-host=0.0.0.0 \
  --contract-deployment-block=0 \
  --grpc-gateway-host=0.0.0.0 \
  --monitoring-host=0.0.0.0 \
  --execution-endpoint=http://eth:8551 \
  --accept-terms-of-use \
  --jwt-secret=${CONFIG_BASE_DIR}/jwtsecret \
  --contract-deployment-block=0 \
  --verbosity=debug \
  --p2p-local-ip=0.0.0.0 \
  --p2p-host-ip=${HOST_IP} \
  --p2p-static-id  \
  --peer=${PEER_INFO} \
  --no-discover \
  --pprof \
  --pprofaddr=0.0.0.0

echo "beacon starting endding "


