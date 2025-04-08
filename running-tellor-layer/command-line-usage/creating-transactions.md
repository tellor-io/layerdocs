---
description: Use the cli to create Tellor Layer transactions.
---

# Creating Transactions

Use `./layerd tx --help` to view available commands.

{% hint style="info" %}
<mark style="color:blue;">Note: the --help flag can be used after any command to show it's sub-commands and required arguments.</mark>
{% endhint %}

```
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
  interchainquery     Transactions commands for the interchainquery module
  mint                Transactions commands for the mint module
  multi-sign          Generate multisig signatures for transactions generated offline
  oracle              Transactions commands for the oracle module
  registry            Transactions commands for the registry module
  reporter            Transactions command for the reporter module
  sign                Sign a transaction generated offline
  sign-batch          Sign transaction batch files
  slashing            Transactions commands for the slashing module
  staking             Staking transaction subcommands
  upgrade             Upgrade transaction subcommands
  validate-signatures validate transactions signatures
  vesting             Vesting transaction subcommands
```

## Examples

### **To send tokens:**

{% code overflow="wrap" %}
```sh
# NOTE: balances of TRB have 6 decimals on layer.
# e.g. sending 123 TRB to tellor18wjwgr0j8pv4ekkpntdylftwz8ml97
./layerd tx bank send $ACCOUNT_NAME tellor18wjwgr0j8pv4ekkpntdylftwz8ml97 123000000loya --fees 5loya --chain-id layertest-4
```
{% endcode %}

### **Sending a Tip (data request):**

Tips can be used by anyone to request data. The tip command has three required arguments.\
`./layerd tx oracle tip [tipper] [query_data] [amount] [flags]` . Here is an example of a tip command for the current USDC/USD Spot Price.

{% code overflow="wrap" %}
```
./layerd tx oracle tip 00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000953706f745072696365000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000004757364630000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000037573640000000000000000000000000000000000000000000000000000000000 10000loya from $ACCOUNT_NAME --fees 12loya --gas auto --chain-id layertest-4
```
{% endcode %}

{% hint style="danger" %}
<mark style="color:blue;">**To prevent spam, Layer requires that a tip a provided for the data that's being reported.**</mark>
{% endhint %}

**Report a value optimistically (requires tipping first):**

{% code overflow="wrap" %}
```sh
# layerd tx oracle submit-value [creator] [qdata] [value] [salt] [flags]
# example for reporter's address tellor1xk9amtcxllqh8s8cyy0kzxhmreuttq0
./layerd tx oracle submit-value tellor1xk9amtcxllqh8s8cyy0kzxhmreuttq0 
00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000953706f745072696365000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000047573646300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000375736400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004a5ba50 --from tellor1xk9amtcxllqh8s8cyy0kzxhmreuttq0 --chain-id 
layertest-4 --fees 1000loya --gas 400000
```
{% endcode %}

_**Note: The query\_data shown here is for usdc-usd-spot . To generate query\_data for the query that you need, check out the**_ [_**"querybuilder" tool here.**_](https://tellor.io/queryidstation/)&#x20;
