---
description: >-
  Example commands for common actions with all required flags. If you can't find
  it here, try `--help`
---

# Commands Reference

_<mark style="color:blue;">**Use the node flag like**</mark><mark style="color:blue;">** **</mark><mark style="color:blue;">**`--node=http://tellorlayer.com:26657`**</mark><mark style="color:blue;">** **</mark><mark style="color:blue;">**to pass in an rpc if you're not running a local node.**</mark>_

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

### examples:

<pre class="language-bash"><code class="lang-bash"><strong># to check balance. Use a tellor address or your local account name.
</strong># e.g. for tellor1p8xk2xqwgszmerk83dvjszddp5adqs5hwaupjt
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


</code></pre>

## Making Transactions

Use `./layerd tx` to transact on layer.

```bash
./layerd tx --help
Transactions subcommands

Usage:
  layerd tx [flags]
  layerd tx [command]

Available Commands:
                      
  auth                Transactions commands for the auth module
  authz               Authorization transactions subcommands
  bank                Bank transaction subcommands
  bridge              Transactions commands for the bridge module
  broadcast           Broadcast transactions generated offline
  consensus           Transactions commands for the consensus module
  decode              Decode a binary encoded transaction string
  dispute             Transactions commands for the dispute module
  distribution        Distribution transactions subcommands
  encode              Encode transactions generated offline
  evidence            Evidence transaction subcommands
  feegrant            Feegrant transactions sub-commands
  globalfee           Transactions commands for the globalfee module
  gov                 Governance transactions subcommands
  group               Group transaction subcommands
  ibc                 IBC transaction subcommands
  ibc-transfer        IBC fungible token transfer transaction subcommands
  interchain-accounts IBC interchain accounts transaction subcommands
  mint                Transactions commands for the mint module
  multi-sign          Generate multisig signatures for transactions generated offline
  oracle              Transactions commands for the oracle module
  registry            Transactions commands for the registry module
  reporter            Transactions commands for the reporter module
  sign                Sign a transaction generated offline
  sign-batch          Sign transaction batch files
  slashing            Transactions commands for the slashing module
  staking             Staking transaction subcommands
  upgrade             Upgrade transaction subcommands
  validate-signatures validate transactions signatures
  vesting             Vesting transaction subcommands

Flags:
      --chain-id string   The network chain ID
  -h, --help              help for tx

Global Flags:
      --home string         directory for config and data (default "/home/spuddy/.layer")
      --log_format string   The logging format (json|plain) (default "plain")
      --log_level string    The logging level (trace|debug|info|warn|error|fatal|panic|disabled or '*:<level>,<key>:<level>') (default "info")
      --log_no_color        Disable colored logs
      --trace               print out full stack trace on errors

Use "layerd tx [command] --help" for more information about a command.
```

### examples:

{% code overflow="wrap" %}
```bash
# to send TRB tokens (demoninated in loya)
# balances of loya have 6 decimals on layer
# e.g. sending 123 TRB to tellor18wjwgr0j8pv4ekkpntdylftwz8ml97
./layerd tx bank send $ACCOUNT_NAME tellor18wjwgr0j8pv4ekkpntdylftwz8ml97 123000000loya --fees 5loya
```
{% endcode %}



