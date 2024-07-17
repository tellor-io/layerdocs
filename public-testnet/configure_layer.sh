#!/bin/bash

# clear the terminal
clear

# Stop execution if any command fails
set -e

# Stop execution if any command fails
source ~/.bashrc

echo "Change denom to loya in config files..."
sed -i 's/([0-9]+)stake/1loya/g' ~/.layer/$ACCOUNT_NAME/config/app.toml
sed -i 's/([0-9]+)stake/1loya/g' ~/.layer/config/app.toml

echo "Set Chain Id to layer in client config file..."
sed -i 's/^chain-id = .*$/chain-id = "layer"/g' ~/.layer/$ACCOUNT_NAME/config/app.toml
sed -i 's/^chain-id = .*$/chain-id = "layer"/g' ~/.layer/config/app.toml

# Modify timeout_commit in config.toml for node
echo "Modifying timeout_commit in config.toml for node..."
sed -i 's/timeout_commit = "5s"/timeout_commit = "1s"/' ~/.layer/$ACCOUNT_NAME/config/config.toml

# Open up node to outside traffic
echo "Open up node to outside traffice" 
sed -i 's/^laddr = "tcp:\/\/127.0.0.1:26657"/laddr = "tcp:\/\/0.0.0.0:26657"/g' ~/.layer/$ACCOUNT_NAME/config/config.toml
sed -i 's/^laddr = "tcp:\/\/127.0.0.1:26656"/laddr = "tcp:\/\/0.0.0.0:26656"/g' ~/.layer/$ACCOUNT_NAME/config/config.toml

sed -i 's/^address = "tcp:\/\/localhost:1317"/address = "tcp:\/\/0.0.0.0:1317"/g' ~/.layer/$ACCOUNT_NAME/config/app.toml

# Modify cors to accept *
echo "Modify cors to accept *"
sed -i 's/^cors_allowed_origins = \[\]/cors_allowed_origins = \["\*"\]/g' ~/.layer/$ACCOUNT_NAME/config/config.toml
sed -i 's/^cors_allowed_origins = \[\]/cors_allowed_origins = \["\*"\]/g' ~/.layer/config/config.toml

# enable unsafe cors
echo "Enable unsafe cors"
sed -i 's/^cors_allowed_origins = \[\]/cors_allowed_origins = \["\*"\]/g' ~/.layer/$ACCOUNT_NAME/config/app.toml
sed -i 's/^enable-unsafe-cors = false/enable-unsafe-cors = true/g' ~/.layer/$ACCOUNT_NAME/config/app.toml
sed -i 's/^enabled-unsafe-cors = false/enabled-unsafe-cors = true/g' ~/.layer/config/app.toml
sed -i 's/^enable-unsafe-cors = false/enable-unsafe-cors = true/g' ~/.layer/config/app.toml

# Modify keyring-backend in client.toml for node
echo "Modifying keyring-backend in client.toml for node..."
sed -i 's/^keyring-backend = "os"/keyring-backend = "'$KEYRING_BACKEND'"/g' ~/.layer/$ACCOUNT_NAME/config/client.toml
# update for main dir as well. why is this needed?
sed -i 's/keyring-backend = "os"/keyring-backend = "'$KEYRING_BACKEND'"/g' ~/.layer/config/client.toml

rm -f ~/.layer/config/genesis.json
rm -f ~/.layer/$ACCOUNT_NAME/config/genesis.json
# get genesis file from running node's rpc
echo "Getting genesis from runnning node....."
curl $LAYER_NODE_URL:26657/genesis | jq '.result.genesis' > ~/.layer/config/genesis.json
curl $LAYER_NODE_URL:26657/genesis | jq '.result.genesis' > ~/.layer/$ACCOUNT_NAME/config/genesis.json

sed -i 's/seeds = ""/seeds = "'$TELLORNODE_ID'@'$LAYER_NODE_URL':26656"/g' ~/.layer/$ACCOUNT_NAME/config/config.toml
sed -i 's/persistent_peers = ""/persistent_peers = "'$TELLORNODE_ID'@'$LAYER_NODE_URL':26656"/g' ~/.layer/$ACCOUNT_NAME/config/config.toml

echo "Path: $TELLORNODE_ID@$LAYER_NODE_URL:26656"

echo "layer has been configured in it's home folder!"