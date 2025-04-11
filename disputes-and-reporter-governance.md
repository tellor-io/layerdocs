---
description: >-
  cli commands and additional context for understanding Tellor reporter slashing
  and dispute governance
hidden: true
icon: gavel
---

# Disputes and Reporter Governance

_**In the unlikely event that there is questionable data reporting on Tellor, anyone who has funds on layer can call propose-dispute to identify the offending reporter and begin the dispute governance process.**_&#x20;

_**This does not happen very often; so, before we do the commands, let's get more familiar with the whole dispute governance and reporter slashing process.**_

### Proposing a Dispute:

When a dispute is proposed, the disputer may choose to pay the entire dispute fee which jails the offending reporter immediately. If the disputer doesn't have enough tokens to cover the dispute fee (e.g. disputing a reporter with a very large stake), they can pay a small portion of the dispute fee and wait for others to pay the rest.&#x20;

Once the fee is paid, the governance process begins, and the offending reporter is jailed. They are also temporarily slashed an amount equal to the dispute fee.

There are three dispute categories: **warning**, **minor**, and **major**. This gives some flexibility to the ways dispute governance can be used to ensure smooth operation of the oracle.

### Dispute Categories:

* **Warning**: The dispute fee / slashing amount is set at 1% of the reporter's bonded tokens. This is similar to the penalty for simple inactivity as a validator. The reporter will be jailed, but they may call unjail immediately to start reporting again with slightly reduced power while the dispute is settled.
* **Minor**: &#x20;

### minor:

The dispute fee / slashing amount is set a 10% of the reporter's bonded tokens. minor disputes should be used if it is not clear whether or not the reporter's activity was truly malicious.

### major:

The dispute fee / slashing amount is set equal to the amount bonded by the reporter. A major dispute aims to completely remove a malicious reporter from the system and should be used only if it is a clear attack on the system or it's users.

### Jail Times

\
If the disputer is a reporter or validator, they can choose whether they want to use bonded tokens or take from their free balance of loya for the dispute fee.\
**To initiate a dispute from the cli:**

<pre class="language-sh" data-overflow="wrap"><code class="lang-sh"><strong># layerd tx dispute propose-dispute [disputed-reporter] [report-meta-id] [report-query-id] [dispute-category] [fee] [pay-from-bond] [flags]
</strong>./layerd tx dispute propose-dispute tellor17gc67q05d5rsz9caznm0s7s5eazg2e3fkk8e 109136 0x0d12ad49193163bbbeff4e6db8294ced23ff8605359fd66799d4e25a3a0e3a warning 555555000000loya true --from ACCOUNT_NAME --gas 500000 --fees 15loya  --chain-id layertest-4 --yes
</code></pre>

{% hint style="warning" %}
#### _<mark style="color:blue;">There is a 48 hour voting period followed by a 24 hour Challenge period after a dispute.</mark>_

_<mark style="color:blue;">**After 72 hours, the dispute is settled and the parties involved can call claim-reward or withdraw-fee-refund depending on which way the community voted.**</mark>_
{% endhint %}

During this time reporters and token holders have the following voting options:

`vote-support:`  You support the disputer and believe that the reporter should be slashed.

`vote-against:` You support the reporter, and believe the disputer should lose their dispute fee as punishment for opening an unnecessary dispute.

`vote-invalid:` It is not clear or not important if the report was incorrect.

{% code overflow="wrap" %}
```sh
# layerd tx dispute vote [id] [vote-choice] [flags]
# full example:
./layerd tx dispute vote 3 vote-invalid --from ACCOUNT_NAME --fees 5loya --chain-id layertest-4
```
{% endcode %}

After 72 hours, the winning party in the dispute can call withdraw-fee-refund to receive the tokens paid by the counter-party in the dispute:

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
