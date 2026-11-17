---
description: Earn staking rewards on Tellor Layer without running a validator or reporter.
icon: hand-coins
---

# Delegating and Selecting

There are many ways to participate and earn as part of the Tellor system. All of them require bridging TRB to the chain via the [decentralized bridge](https://hub.tellor.io/). Deposits and withdrawals have a **12–14 hour delay**, so plan accordingly.

{% hint style="info" %}
Don't have TRB on Tellor Layer yet? Follow the [Bridging TRB](README.md) guide first.
{% endhint %}

Once your TRB has arrived on Tellor Layer, you can earn rewards **without running any infrastructure of your own**. You do this in two steps:

1. **Delegate** your stake to a validator.
2. **Select** a reporter.

Your stake works in two places: delegating adds it to your validator's **consensus power**, and selecting adds it to your reporter's **reporting power**. Validators and reporters each earn rewards from their work — and each take a commission — so delegating alone earns only the validator side of rewards. You must **also select a reporter** to earn "full" inflationary rewards. Commission rates for every validator and reporter are listed on the [explorer](https://explorer.tellor.io/).

## Step 1: Delegate to a validator

Carefully choose a validator to delegate your chosen stake size to. Your delegation increases that validator's power while you earn rewards, minus the validator's commission. Losses can occur due to your validator's inactivity or misbehavior, so choose one you trust.

{% hint style="info" %}
Please choose a **smaller validator** to help keep the chain operationally healthy. You can browse current validators and their size here: [explorer.tellor.io/validators](https://explorer.tellor.io/validators)
{% endhint %}

To delegate from the command line:

{% content-ref url="../command-line-usage/leveraging-layerd/delegate-to-a-validator.md" %}
[delegate-to-a-validator.md](../command-line-usage/leveraging-layerd/delegate-to-a-validator.md)
{% endcontent-ref %}

## Step 2: Select a reporter

After you select a validator, you will want to select a reporter to earn **"full" inflationary rewards**. Your selection increases that reporter's reporting power while you earn rewards, minus the reporter's commission. Losses can occur if that reporter is disputed, so be sure to choose an active reporter who you trust.

{% hint style="info" %}
Be sure to choose a **smaller reporter** so that the network stays decentralized, and double check that your reporter has been live. Historical liveness tracking can be found in the [#reporter-liveness channel on the Tellor Discord](https://discord.gg/tellor).
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
./layerd tx staking unbond tellorvaloper1dct4uwgcfjxqaphjm33n9fycxdz2m6 12000000loya --from YOUR_ACCOUNT_NAME --fees 5loya --chain-id tellor-1 --node https://mainnet.tellorlayer.com/rpc/
```
{% endcode %}

To move your stake to a different validator without waiting out the unbonding period, use `layerd tx staking redelegate [old-validator-addr] [new-validator-addr] [amount]`.

To change reporters without unstaking, submit a new `select-reporter` transaction (or `switch-reporter`) pointing at your new choice.

## Tools for stakers

The live Tellor operator dashboard is useful for modeling, tracking, sources, and links:

**[operator.tellor.io/?tab=tracker](https://operator.tellor.io/?tab=tracker)**

The **MODELER** tab has a tool for calculating projected rewards from historical data before you commit your stake.

{% hint style="info" %}
Ready to go further? Running your own validator or reporter is covered under [Running Tellor](../running-tellor/getting_started.md).
{% endhint %}
