---
description: >-
  Example commands for common actions with all required flags. If you can't find
  it here, try `--help`
---

# Commands Reference

## querying the RPC&#x20;

Use `./layerd query` commands to find detailed information on the state of the chain.

```bash
Querying subcommands

Usage:
  layerd query [flags]
  layerd query [command]

Aliases:
  query, q

Available Commands:
  auth                Querying commands for the auth module
  authz               Querying commands for the authz module
  bank                Querying commands for the bank module
  block               Query for a committed block by height, hash, or event(s)
  bridge              Querying commands for the bridge module
  comet-validator-set Get the full CometBFT validator set at given height
  consensus           Querying commands for the consensus module
  dispute             Querying commands for the dispute module
  distribution        Querying commands for the distribution module
  evidence            Querying commands for the evidence module
  feegrant            Querying commands for the feegrant module
  globalfee           Querying commands for the global fee module
  gov                 Querying commands for the gov module
  group               Querying commands for the group module
  ibc                 Querying commands for the IBC module
  ibc-transfer        IBC fungible token transfer query subcommands
  interchain-accounts IBC interchain accounts query subcommands
  oracle              Querying commands for the oracle module
  registry            Querying commands for the registry module
  reporter            Querying commands for the reporter module
  slashing            Querying commands for the slashing module
  staking             Querying commands for the staking module
  tx                  Query for a transaction by hash, "<addr>/<seq>" combination or comma-separated signatures in a committed block
  tx                  Query for a transaction by hash, "<addr>/<seq>" combination or comma-separated signatures in a committed block
  txs                 Query for paginated transactions that match a set of events
  upgrade             Querying commands for the upgrade module

Flags:
      --chain-id string   The network chain ID
  -h, --help              help for query

Global Flags:
      --home string         directory for config and data (default "/Users/sloetter/.layer")
      --log_format string   The logging format (json|plain) (default "plain")
      --log_level string    The logging level (trace|debug|info|warn|error|fatal|panic|disabled or '*:<level>,<key>:<level>') (default "info")
      --log_no_color        Disable colored logs
      --trace               print out full stack trace on errors

Use "layerd query [command] --help" for more information about a command.
```

examples:

```bash
# to check balance. Use a tellor address or your local account name.
# e.g. for tellor1p8xk2xqwgszmerk83dvjszddp5adqs5hwaupjt
./layerd query bank balance tellor1p8xk2xqwgszmerk83dvjszddp5adqs5hwaupjt loya

# get a list of validators and their status
./layerd query staking validators

# get info about a validator by it's moniker. 
./layerd query staking validators | grep -A 5 "bob_moniker"

# get a list of reporters
./layerd query reporter reporters

# to check rewards
# delegator-addr should be a tellor prefix address
# validator-addr should be a tellorvaloper prefix address
# both addresses are required even if validator and reporter are same account
./layerd query distribution rewards-by-validator [delegator-addr] [validator-addr]

# to examine a transaction (tx)
# example for tx hash 9CE91600D5291C0CD267F950AC254AA469FE97C8444EFE9EC8E9E41BD4DEE523
./layerd query tx --type=hash 9CE91600D5291C0CD267F950AC254AA469FE97C8444EFE9EC8E9E41BD4DEE523


```

## Building and Signing Transactions

To send tokens:

```
./layerd tx bank send $ACCOUNT_NAME <recipients_address> <amount>loya --fees 5loya
```

Add the `--node` flag to any command if you don't have a local node. Here's a full example of a send tx for 123 TRB using remote RPC:

{% code overflow="wrap" %}
```bash
./layerd tx bank send $ACCOUNT_NAME tellor18wjwgr0j8pv4ektdaxvzsykpntdylftwz8ml97 123000000loya --fees 10loya --node=http://tellorlayer.com:26657
```
{% endcode %}

To request withdraw of your tokens from layer to sepolia. In this example, the layer address is `tellor1suuc9d5dr5stps5tzjv5d95ur02827ardn5` and the ethereum address that we want to withdraw to is `0x7660794eF8f978Ea0922DC29B4d93e1fc94A`:

{% code overflow="wrap" %}
```bash
./layerd tx bridge withdraw-tokens tellor1suuc9d5dr5stps5tzjv5d95ur02827ardn5 7660794eF8f978Ea0922DC29B4d93e1fc94A 69010069loya --fees 5loya
```
{% endcode %}

To delegate to a validator:

{% code overflow="wrap" %}
```bash
# delegating voting power to tellor18wjwgr0j8pv4ektdaxvzsykpntdylftwz8ml97
./layerd tx staking delegate tellorvaloper1dct4uwgcfjxqaphjmfzjv2yz733n9fycxdz2m6 123000000loya --from $ACCOUNT_NAME --fees 5loya --chain-id layertest-2
```
{% endcode %}

To select a reporter with your bonded token power (must be delegated to a validator first):

{% code overflow="wrap" %}
```bash
# selecting tellor148zgkh394d382g4rft3dhlv32wx0g6r743vv4q
./layerd tx reporter select-reporter tellor148zgkh394d382g4rft3dhlv32wx0g6r743vv4q --from $ACCOUNT_NAME --chain-id layertest-2 --fees 5loya --node=http://layer-node.com:26758
```
{% endcode %}

To start layer as a validator /reporter:

{% code overflow="wrap" %}
```sh
./layerd start --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false --key-name $ACCOUNT_NAME --home ~/.layer
```
{% endcode %}

Start layer with cosmovisor:

{% code overflow="wrap" %}
```sh
./cosmovisor run start --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false --key-name $ACCOUNT_NAME --home ~/.layer
```
{% endcode %}
