---
description: Help with a few common setup problems. (more to be added in this section soon)
---

# State Sync Troubleshooting

## State Sync Failed!?

There are three main reasons why a state sync will fail:

* RPC connection fails, or is rate limited
* Not enough healthy peers / seeds configured
* Incorrect trusted height / trusted hash

### Steps to Fix:

1\) Stop the node process with `ctrl^c` (or `sudo systemctl stop layer` if it's a service)

2\) Remove the chain data from `~/.layer/data/`, being careful to NOT delete the `priv_validator_state.json` file:

```sh
# Delete the binaries
# This is useful if you're not sure that you downloaded the right binaries:
rm -rf ~/layer/binaries

# deletes chain data
# This is useful if state sync fails and you need to try a different config
rm -rf ~/.layer/data/application.db; \
rm -rf ~/.layer/data/blockstore.db; \
rm -rf ~/.layer/data/cs.wal; \
rm -rf ~/.layer/data/evidence.db; \
rm -rf ~/.layer/data/snapshots; \
rm -rf ~/.layer/data/state.db; \
rm -rf ~/.layer/data/tx_index.db
```

Next, open up your configs.

```sh
nano ~/.layer/config/config.toml
```

Use `ctrl^w` to search, or scroll down to the `[p2p]` section.

```toml
#######################################################
###           P2P Configuration Options             ###
#######################################################
[p2p]

# Address to listen for incoming connections
laddr = "tcp://0.0.0.0:26656"

# Address to advertise to peers for them to dial. If empty, will use the same
# port as the laddr, and will introspect on the listener to figure out the
# address. IP and port are required. Example: 159.89.10.97:26656
external_address = ""

# Comma separated list of seed nodes to connect to
seeds = "f4786bc2a40172e29784b9f8d..."

# Comma separated list of nodes to keep persistent connections to
persistent_peers = "f4786bc2a40172e29784b9f8d69567c474d..."

# Path to address book
addr_book_file = "config/addrbook.json"

# Set true for strict address routability rules
# Set false for private or local networks
addr_book_strict = false

```

Try manually editing the seeds and persistent\_peers to match [those shown here](peers-list-and-public-rpcs.md).

In most cases `addr_book_strict` can be safely changed to `true`.&#x20;

Find the `[statesync]` section.

```toml
#######################################################
###         State Sync Configuration Options        ###
#######################################################
[statesync]
# State sync rapidly bootstraps a new node by discovering, fetching, and restoring a state machine
# snapshot from peers instead of fetching and replaying historical blocks. Requires some peers in
# the network to take and serve state machine snapshots. State sync is not attempted if the node
# has any local state (LastBlockHeight > 0). The node will have a truncated block history,
# starting from the height of the snapshot.
enable = true

# RPC servers (comma-separated) for light client verification of the synced state machine and
# retrieval of state data for node bootstrapping. Also needs a trusted height and corresponding
# header hash obtained from a trusted source, and a period during which validators can be trusted.
#
# For Cosmos SDK-based chains, trust_period should usually be about 2/3 of the unbonding time (~2
# weeks) during which they can be financially punished (slashed) for misbehavior.
rpc_servers = "https://tellor-testnet.nirvanalabs.xyz/tellor-testnet-public/,https://node-palmito.tellorlayer.com/rpc/"
trust_height = 217310
trust_hash = "F526C5B5C79DECDC27F555A96A7B3F33444DE060AD5C9A02A7F5D15C5DBE85"
trust_period = "168h0m0s"

# Time to spend discovering snapshots before initiating a restore.
discovery_time = "15s"
```

_**Take a moment to check that****&#x20;****`enable = true`****&#x20;****, and check that your rpc\_servers, trust\_height are configured using the steps shown in**_[ _**Node Setup**_](./)_**. (be careful to choose the tabs that match your system)**_

The `trust_period` should be left alone, and the `discovery_time` can be safely increased to "30s".\
\
