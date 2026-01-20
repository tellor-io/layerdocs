---
description: Templates for systemd service files that work with Tellor
---

# Example .service Files

Tellor requires two separate services that use two different binaries: `layerd` and `reporterd`.&#x20;

For running the layer node client (`layerd`):

```sh
[Unit]
Description=Layer Node Client
After=network-online.target

[Service]
User=USERNAME
Group=USERNAME
WorkingDirectory=/home/USERNAME/path/to/layer
ExecStart=/home/USERNAME/path/to/layerd start --home /home/USERNAME/.layer --keyring-backend="test" --key-name=ACCOUNT_NAME  --api.enable --api.swagger
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

For running the reporter daemon (`reporterd`):

```sh
[Unit]
Description=Layer Reporter
After=network-online.target

[Service]
User=USERNAME
Group=USERNAME
WorkingDirectory=/home/USERNAME/path/to/layer
ExecStart=/home/path/to/layer/daemons/bin/reporterd --chain-id tellor-1 --grpc-addr 0.0.0.0:9090 --from ACCOUNT_NAME --home /home/USERNAME/.layer --keyring-backend test --node tcp://0.0.0.0:26657
Restart=always
RestartSec=10
Environment="ETH_RPC_URL=https://your.ethereum.rpc_url"
Environment="ETH_RPC_URL_PRIMARY=https://your.ethereum.rpc_url" # again
Environment="ETH_RPC_URL_FALLBACK=https://your.fallback.ethereum.rpc_url"
Environment="TOKEN_BRIDGE_CONTRACT="
Environment="WITHDRAW_FREQUENCY=3600"
Environment="REPORTERS_VALIDATOR_ADDRESS=tellorvaloper1_your_address"
Environment="CMC_PRO_API_KEY=YOUR_COINMARKETCAP_API_KEY"
Environment="SUBGRAPH_API_KEY=YOUR_GRAPH_API_KEY"
Environment="INFURA_API_KEY=YOUR_INFURA_API_KEY"
Environment="ALCHEMY_API_KEY=YOUR_ALCHEMY_API_KEY"

[Install]
WantedBy=multi-user.target
```

For running a layer validator with cosmovisor:

{% code overflow="wrap" %}
```shell
[Unit]
Description=Cosmovisor Validator Start
After=network-online.target

[Service]
User=USERNAME
Group=USERNAME
WorkingDirectory=/home/USERNAME/layer
ExecStart=/home/USERNAME/cosmovisor run start --home /home/USERNAME/.layer --keyring-backend="test" --key-name="ACCOUNT_NAME" --api.enable --api.swagger
Restart=always
RestartSec=10
MemoryMax=25G
Environment="DAEMON_NAME=layerd"
Environment="DAEMON_HOME=/home/USERNAME/.layer"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=false"
Environment="DAEMON_POLL_INTERVAL=300ms"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="DAEMON_PREUPGRADE_MAX_RETRIES=0"


[Install]
WantedBy=multi-user.target
```
{% endcode %}

