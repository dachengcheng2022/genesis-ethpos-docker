#!/bin/bash
set -e

validator \
  --datadir=${DATA_DIR}/validatordata \
  --accept-terms-of-use \
  --interop-num-validators=64 \
  --interop-start-index=0 \
  --force-clear-db \
  --chain-config-file=${DATA_DIR}/config.yml \
  --config-file=${DATA_DIR}/config.yml \
  --beacon-rpc-provider=127.0.0.1:4000
