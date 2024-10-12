
### 0 clone code
```shell
cd /opt
git clone https://github.com/dachengcheng2022/genesis-ethpos-docker.git
cd genesis-ethpos-docker
git checkout release
```
### 1 docker build 
###### 1.1 before build need modify /consensus-docker-base directory account_password and wallet_password's password. it the same as 2.2 keystore_password params
```shell
docker-compose build --no-cache
```

### 2 create validator keys
###### 2.1 replace your mnemonic
###### 2.2 replace your keystore_password
###### 2.3 replace your execution_address is withdraw address
```shell
docker-compose run staking-cli \
--language=English \
--non_interactive \
existing-mnemonic \
--folder /basicconfig \
--mnemonic="drink grab giant fruit tell night fiction raven nominee swing side gauge soccer ecology caution virtual bomb knee wife flower produce can negative fiction" \
--keystore_password=12345678 \
--chain="mainnet" \
--validator_start_index=0 \
--num_validators=3 \
--execution_address=0x161783e9f3d16d0d5a8e5027805c7a54dfe61e03 \
--devnet_chain_setting=/config_deposit.yml
```
```shell powershell
docker-compose run staking-cli --language=English --non_interactive existing-mnemonic --folder /basicconfig --mnemonic="crash dog curtain surface river current wood describe secret fan wear castle sea noble welcome seat antenna wear tray point media ocean destroy mom" --keystore_password=12345678 --chain="mainnet" --validator_start_index=0 --num_validators=3 --execution_address=0xCBf79Ae1b1b58Eb6b84Ad159588d35A71dE49b6c --devnet_chain_setting=/config_deposit.yml
````
### 3 beacon init
```shell
docker-compose run beaconbase beacon_init.sh
```

it will create genesis.json, geneisi.szz in the ./basciconfig

### 4 validator init 
```shell
docker-compose run beaconbase validator_init.sh
```

### 5 geth init 
```shell
docker-compose run ethbase eth_init.sh
```

### 6 run geth 
```shell
docker-compose up -d eth
```

### 7 run beacon and validator 
```shell
docker-compose up -d beacon
```


### modify deposit contrcat address

