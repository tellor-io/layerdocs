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
Environment="TOKEN_BRIDGE_V2_ADDRESS=0x6ec401744008f4B018Ed9A36f76e6629799Ee50E"

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
WorkingDirectory=/home/USERNAME/layer/binaries/reporter
ExecStart=/home/USERNAME/layer/binaries/reporter/reporterd
Restart=always
RestartSec=10
# Reporter identity
Environment="LAYER_HOME=/home/USERNAME/.layer"
Environment="FROM=ACCOUNT_NAME"
Environment="KEYRING_BACKEND=test"
# Environment="KEYRING_PASSWORD_FILE=/etc/layer-daemons/reporter-keyring-password"  # required when KEYRING_BACKEND=file
Environment="RPC_NODES=tcp://127.0.0.1:26657"
Environment="GRPC_NODES=127.0.0.1:9090"
Environment="BRIDGE_CHAIN_RPC_NODES=https://mainnet.infura.io/v3/YOUR_INFURA_API_KEY,https://eth-mainnet.g.alchemy.com/v2/YOUR_ALCHEMY_API_KEY"
Environment="ETH_MAINNET_RPC_NODES=https://mainnet.infura.io/v3/YOUR_INFURA_API_KEY,https://eth-mainnet.g.alchemy.com/v2/YOUR_ALCHEMY_API_KEY"
Environment="REPORTERS_VALIDATOR_ADDRESS=tellorvaloper1_your_address"
Environment="WITHDRAW_FREQUENCY=43200"
Environment="CMC_PRO_API_KEY=YOUR_COINMARKETCAP_API_KEY"
Environment="CGPRO_API_KEY=YOUR_COINGECKO_PRO_API_KEY"
Environment="SUBGRAPH_API_KEY=YOUR_GRAPH_API_KEY"
Environment="INFURA_API_KEY=YOUR_INFURA_API_KEY"
Environment="ALCHEMY_API_KEY=YOUR_ALCHEMY_API_KEY"
# Optional v0.2.7 settings:
# Environment="REMOTE_SIGNER_ADDR=127.0.0.1:9191"
# Environment="REMOTE_SIGNER_CA_CERT=/etc/layer-daemons/remote-signer-ca.pem"
# Environment="REMOTE_SIGNER_CLIENT_CERT=/etc/layer-daemons/remote-signer-client.pem"
# Environment="REMOTE_SIGNER_CLIENT_KEY=/etc/layer-daemons/remote-signer-client-key.pem"
# Environment="DISPUTE_MONITOR_ENABLED=false"
# Environment="API_URLS=http://localhost:1317"
# Environment="CUSTOM_QUERY_CACHE_TTL=3s"

[Install]
WantedBy=multi-user.target
```

When using `KEYRING_BACKEND=file`, also set `KEYRING_PASSWORD_FILE` to a password file readable only by the service user. See the [layer-daemons README](https://github.com/tellor-io/layer-daemons/blob/v0.2.7/README.md#keyring-password-file) for setup details.

Alternatively, you can load all reporter settings from a file:

```sh
EnvironmentFile=/home/USERNAME/layer/binaries/reporter/.env
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
Environment="TOKEN_BRIDGE_V2_ADDRESS=0x6ec401744008f4B018Ed9A36f76e6629799Ee50E"


[Install]
WantedBy=multi-user.target
```
{% endcode %}
