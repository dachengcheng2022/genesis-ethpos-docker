docker rm -f $(docker ps -a -q) || true
docker rmi block.com/geth || true
docker rmi block.com/beacon-chain || true
docker compose down || true
rm -Rf ./consensus/ || true
rm -Rf ./execution/ || true
mkdir consensus
mkdir execution