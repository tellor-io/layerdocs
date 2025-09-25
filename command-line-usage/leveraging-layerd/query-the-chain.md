---
description: >-
  Use the cli to query Tellor for information about accounts, validators,
  reports, disputes, governance and more.
---

# Query the Chain

{% hint style="info" %}
_<mark style="color:blue;">**Use the node flag like**</mark><mark style="color:blue;">**&#x20;**</mark><mark style="color:blue;">**`--node=http://tellorlayer.com:26657`**</mark><mark style="color:blue;">**&#x20;&#x20;**</mark><mark style="color:blue;">**to query the chain without running a local node.**</mark>_
{% endhint %}

If you don't already have the binary, download the latest release [here](https://github.com/tellor-io/layer/tags).&#x20;

The full list of `./layerd query` as shown via `./layerd query --help` :

```sh
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
  upgrade             Querying commands for the upgrade mod
```

### examples:

```sh
# to check balance. Use a tellor address or your local account name.
# e.g. for tellor1p8xk2xqwgszmerk83dvjszddp5adqs5hwaupjt
./layerd query bank balance tellor1p8xk2xqwgszmerk83dvjszddp5adqs5hwaupjt loya

# get a list of validators and their status
./layerd query staking validators

# get info about a validator by it's moniker. 
./layerd query staking validators | grep -A 5 "bob_moniker"

# get a list of reporters
./layerd query reporter reporters

# get a list of their reportrs
# e.g. for tellor1d8rrlk20qqxd69xl2zen503x7uux0wnl
./layerd query oracle get-reportsby-reporter tellor1d8rrlk20qqxd69xl2zen503x7uux0wnl

# check the reporter address that your account is selecting
# any address may also be used instead of $ACCOUNT_NAME
./layerd query reporter selector-reporter $ACCOUNT_NAME

# get governance information
./layerd query gov proposals

# get gov proposal vote tallies
./layerd query gov tally 1

# get list of open dispute IDs
./layerd query dispute open-disputes

# query record of disputes with more information
./layerd query dispute disputes

# check rewards
# delegator-addr should be a tellor prefix address
# validator-addr should be a tellorvaloper prefix address
# both addresses are required even if validator and reporter are same account
./layerd query distribution rewards-by-validator [delegator-addr] [validator-addr]

# to examine a transaction (tx)
# example for tx hash 9CE91600D5291C0CD267F950AC254AA469FE97C8444EFE9EC8E9E41BD4DEE523
./layerd query tx --type=hash 9CE91600D5291C0CD267F950AC254AA469FE97C8444EFE9EC8E9E41BD4DEE523
```
