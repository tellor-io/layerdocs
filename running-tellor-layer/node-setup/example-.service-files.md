---
description: Templates for systemd service files that work with Tellor Layer
---

# Example .service Files

Tellor Layer requires two separate services that use two different binaries: `layerd` and `reporterd`.&#x20;

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
Environment="MC_PRO_API_KEY=YOUR_COINMARKETCAP_API_KEY"
Environment="SUBGRAPH_API_KEY=YOUR_GRAPH_API_KEY"

[Install]
WantedBy=multi-user.target
```

