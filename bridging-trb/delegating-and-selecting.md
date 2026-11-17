---
description: Earn staking rewards on Tellor Layer without running a validator or reporter.
icon: hand-coins
---

# Delegating and Selecting

There are many ways to participate and earn as part of the Tellor system. The first step is bridging TRB to the chain via the [decentralized bridge](https://hub.tellor.io/). Deposits and withdrawals have a **12–14 hour delay**.

{% hint style="info" %}
Don't have TRB on Tellor Layer yet? Follow the [Bridging TRB](README.md) guide first.
{% endhint %}

Once your TRB has arrived on Tellor Layer, you can earn rewards **without running any infrastructure of your own**. You do this in two steps:

1. **Delegate** your stake to a validator.
2. **Select** a reporter.

Your stake works in two places: delegating adds it to a validator's **consensus power**, and selecting adds it to a reporter's **reporting power**. Validators and reporters charge a commission for the service.

## Step 1: Delegate to a validator

Carefully choose a validator to delegate your chosen stake size to. Your delegation increases that validator's power while you earn rewards, minus the validator's commission. Tellor is a fully public, permissionless, and decentralized network. You should only delegate TRB to a validator who you trust.

{% hint style="info" %}
Please choose a **small or medium sized validator** to help keep the chain operationally healthy. You can browse current validators and their size here: [explorer.tellor.io/validators](https://explorer.tellor.io/validators)
{% endhint %}

To delegate from the command line:

{% content-ref url="../command-line-usage/leveraging-layerd/delegate-to-a-validator.md" %}
[delegate-to-a-validator.md](../command-line-usage/leveraging-layerd/delegate-to-a-validator.md)
{% endcontent-ref %}

## Step 2: Select a reporter

After you select a validator, there is an additional action required to earn the most rewards: selecting a reporter. Your selection increases that reporter's reporting power while you earn rewards, minus the reporter's commission. Losses can occur if that reporter is disputed, so be sure to choose an active reporter who you trust.

{% hint style="info" %}
Be sure to choose a **small or medium sized reporter** so that the network stays decentralized, and double check that your reporter has been live. Historical liveness tracking can be found in the [#reporter-liveness channel on the Tellor Discord](https://discord.gg/tellor).
{% endhint %}

To select a reporter from the command line:

{% content-ref url="../command-line-usage/leveraging-layerd/select-a-reporter.md" %}
[select-a-reporter.md](../command-line-usage/leveraging-layerd/select-a-reporter.md)
{% endcontent-ref %}

## Unstaking and switching

When you want your stake back, unbond it from your validator. Unbonded tokens take **21 days** to become liquid and spendable again:

{% code overflow="wrap" %}
```sh
# layerd tx staking unbond [validator-addr] [amount] [flags]
./layerd tx staking unbond tellorvaloper1dct4uwexample3n9fycxdz2m6 12000000loya --from YOUR_ACCOUNT_NAME --fees 5loya --chain-id tellor-1 --node https://mainnet.tellorlayer.com/rpc/
```
{% endcode %}

To move your stake to a different validator without waiting out the unbonding period, use `layerd tx staking redelegate [old-validator-addr] [new-validator-addr] [amount]`.

To change reporters without unstaking, submit a `switch-reporter` transaction pointing at your new choice. (`select-reporter` only works the first time you choose a reporter; once you have one, all changes go through `switch-reporter`.)

{% code overflow="wrap" %}
```sh
# layerd tx reporter switch-reporter [new-reporter-address] [flags]
./layerd tx reporter switch-reporter tellor148zgkh394dexamplex0g6r743vv4q --from YOUR_ACCOUNT_NAME --fees 5loya --chain-id tellor-1 --node https://mainnet.tellorlayer.com/rpc/
```
{% endcode %}

## Tools for stakers

The live Tellor operator dashboard is useful for modeling, tracking, sources, and links:

**[operator.tellor.io/?tab=tracker](https://operator.tellor.io/?tab=tracker)**

The **MODELER** tab has a tool for calculating projected rewards from historical data before you commit your stake.

{% hint style="info" %}
Ready to go further? Running your own validator or reporter is covered under [Running Tellor](../running-tellor/getting_started.md).
{% endhint %}
