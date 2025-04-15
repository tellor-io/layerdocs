---
description: >-
  cli commands and additional context for understanding Tellor reporter slashing
  and dispute governance
icon: gavel
---

# Disputes and Reporter Governance

### Overview:

Tellor reporters are subject to novel dispute mechanisms designed to ensure data integrity. If questionable data is identified or a reporter is suspected of acting maliciously, any participant holding TRB on the network can initiate a dispute. This open and transparent process empowers the community to govern reporters collectively.&#x20;

Here's how it works:

The disputer must pay a dispute fee that is based on the severity of the offense and the size of the offending reporter's stake. If they can't afford the dispute fee, they can alert the community and ask for help funding the dispute.

Once the fee is paid, the governance process begins, and the offending reporter is jailed. They are also temporarily slashed an amount equal to the dispute fee.

There are three dispute categories: **warning**, **minor**, and **major**. This gives some flexibility to the ways dispute governance can be used to ensure smooth operation of the oracle.

Dispute information can be queried using the following cli commands:

```
// Some code
```

### Dispute Categories:

* <mark style="color:yellow;">**Warning**</mark>: The dispute fee / slashing amount is set at 1% of the reporter's bonded tokens. This is similar to the penalty for simple inactivity as a validator. The reporter will be jailed, but they may call \`unjail\` immediately to start reporting again with slightly reduced power while the dispute is settled.
* <mark style="color:orange;">**Minor**</mark>:  The dispute fee / slashing amount is set a 5% of the reporter's bonded tokens. The reporter is jailed for 10 minutes.&#x20;
* <mark style="color:red;">**Major**</mark>: The dispute fee / slashing amount is set equal to the amount bonded by the reporter. The reporter will be jailed forever unless the vote result is `against`.

## How to Propose a Dispute

The propose-dispute command has 6 arguments:

{% code overflow="wrap" %}
```sh
layerd tx dispute propose-dispute [disputed-reporter] [report-meta-id] [report-query-id] [dispute-category] [fee] [pay-from-bond] [flags]
```
{% endcode %}

**\[disputed-reporter]**: the "tellor" prefix address of the bad reporter

**\[report-meta-id]**: The bad report's meta id

**\[report-query-id]**: The bad report's query id

**\[dispute-category]**: (see above)

**\[fee]**: The amount of the dispute fee that you would like to pay while proposing the dispute. Setting this to any value that is larger than the required dispute fee will only remove the exact fee amount from your wallet or bond. for example, if the dispute fee is 12345loya and fee=999999999999loya, the amount taken to pay the dispute fee will be 12345loya.

**\[pay-from-bond]**: set this to True if you want to use bonded tokens to pay the dispute fee. You might want to do this if you don't have enough free balance to pay the fee. Set this to "False" to use free balance only.

Full example:

{% code overflow="wrap" %}
```sh
./layerd tx dispute propose-dispute tellor17gc67q05d5rsz9caznm0s7s5eazg2e3fkk8e 109136 0x0d12ad49193163bbbeff4e6db8294ced23ff8605359fd66799d4e25a3a0e3a warning 555555000000loya false --from ACCOUNT_NAME --gas 500000 --fees 15loya  --chain-id layertest-4 --yes
```
{% endcode %}

{% hint style="warning" %}
#### _<mark style="color:blue;">There is a 48 hour voting period followed by a 24 hour Challenge period after a dispute.</mark>_

_<mark style="color:blue;">**After 72 hours, the dispute is settled and the parties involved can call withdraw-fee-refund to claim any tokens that were awarded from the dispute. Also, all the reporters who voted on the dispute can call claim-reward to receive their share of 2.5% of the dispute fee!**</mark>_&#x20;
{% endhint %}

### Adding Funds to the Dispute Fee

In the event that a disputer is unable to pay the entire dispute fee, anyone who wants to support the dispute financially can call `add-fee-to-dispute` . All fee payers earn a proportionate amount of the reward funds from the dispute if the rest of the community votes to support it. Likewise, if the community votes "against", the entire fee is forfeited to the accused reporter. Example:

<pre class="language-sh" data-overflow="wrap"><code class="lang-sh"><strong># layerd tx dispute add-fee-to-dispute [dispute-id] [amount] [pay-from-bond] [flags]
</strong>/layerd tx dispute add-fee-to-dispute 2 2023500loya false --from ACCOUNT_NAME --fees 5loya
</code></pre>

### What Happens if the Dispute Fee is Not Paid?

If the dispute fee is not paid in full while the dispute is active, the dispute will automatically settle "invalid". Anyone who paid a partial dispute fee can call `withdraw-fee-refund` to get those funds back. Example:

{% code overflow="wrap" %}
```sh
# layerd tx dispute withdraw-fee-refund [payer-address] [id] [flags]
./layerd tx dispute withdraw-fee-refund tellor1vw2yy9nf3wz7hey89tpw5hn0yr3hkrzt889x47 3 --from cypher --fees 5loya --chain-id layertest-4 --yes
```
{% endcode %}

## Voting

There are three different choices when voting on a dispute:

`vote-support:`  You support the disputer and believe that the reporter should be slashed. The disputer receives all of the reporter's tokens, and they are refunded the dispute fee minus 2.5% that was taken out for voter rewards.

`vote-against:` You support the reporter, and believe the disputer should lose their dispute fee as punishment for opening an unnecessary dispute. The reporter gets their tokens back minus 2.5% that was taken out for voter rewards.&#x20;

`vote-invalid:` It is not clear or not important if the reporter was wrong or malicious. The reporter gets all of their tokens back, and the disputer gets back the fee minus 2.5% that was taken out for voter rewards.

{% code overflow="wrap" %}
```sh
# layerd tx dispute vote [id] [vote-choice] [flags]
# full example:
./layerd tx dispute vote 3 vote-invalid --from ACCOUNT_NAME --fees 5loya --chain-id layertest-4
```
{% endcode %}

## Settling the Dispute

After 72 hours, the winning party (or parties if invalid) in the dispute can call withdraw-fee-refund to receive the tokens paid by the counter-party in the dispute:

{% code overflow="wrap" %}
```sh
./layerd tx dispute withdraw-fee-refund 2 --from ACCOUNT_NAME --fees 5loya --chain-id layertest-4
```
{% endcode %}

Any accounts that voted may call claim-reward to receive a small reward for voting. The amount that you get for voting is a token-weighted share of 2.5% of the dispute fee.

{% code overflow="wrap" %}
```sh
# layerd tx dispute claim-reward [dispute_id] [flags]
./layerd tx dispute claim-reward 2 --from ACCOUNT_NAME --fees 5loya --chain-id layertest-4
```
{% endcode %}
