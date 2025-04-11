---
description: >-
  cli commands and additional context for understanding Tellor reporter slashing
  and dispute governance
hidden: true
---

# Disputes and Reporter Governance

_In the unlikely event that there is an incorrect or malicious data report to the Tellor oracle, anyone who has funds on layer can call **propose-dispute** to remove that value from the database and initiate the dispute governance process. Before we think about doing the commands, let's get more familiar with the whole dispute governance and reporter slashing process._

{% hint style="info" %}
Visit the Data Feed to see the oracle data being reported in real time [here](https://explorer.tellor.io/data-feed).
{% endhint %}

### Dispute Resolution / Governance

When a dispute is proposed, the disputer pays a dispute fee and the reporter is temporarily slashed an equal amount. The reporter will be also be "jailed" and unable to report until the dispute is settled.  If the disputer is a reporter or validator, they can choose whether they want to use bonded tokens or take from their free balance of loya for the dispute fee.

There are three dispute categories: warning, minor, and major.&#x20;

### warning:

The dispute fee / slashing amount is set at 1% of the reporter's bonded tokens. This is similar to the penalty for simple inactivity as a validator.&#x20;

### minor:

The dispute fee / slashing amount is set a 10% of the reporter's bonded tokens. minor disputes should be used if it is not clear whether or not the reporter's activity was truly malicious.

### major:

The dispute fee / slashing amount is set equal to the amount bonded by the reporter. A major dispute aims to completely remove a malicious reporter from the system and should be used only if it is a clear attack on the system or it's users.\
\
**To initiate a dispute from the cli:**

<pre class="language-sh" data-overflow="wrap"><code class="lang-sh"><strong># layerd tx dispute propose-dispute [disputed-reporter] [report-meta-id] [report-query-id] [dispute-category] [fee] [pay-from-bond] [flags]
</strong>./layerd tx dispute propose-dispute tellor17gc67q05d5rsz9caznm0s7s5eazg2e3fkk8e 109136 0x0d12ad49193163bbbeff4e6db8294ced23ff8605359fd66799d4e25a3a0e3a warning 555555000000loya true --from ACCOUNT_NAME --gas 500000 --fees 15loya  --chain-id layertest-4 --yes
</code></pre>

There is a 24 hour voting period after the dispute. During this time reporters and token holders have the following voting options:

`vote-support:`  You support the disputer and believe that the reporter should be slashed.

`vote-against:` You support the reporter, and believe the disputer should lose their dispute fee as punishment for opening an unnecessary dispute.

`vote-invalid:` It is not clear or not important if the report was incorrect.

{% code overflow="wrap" %}
```sh
# layerd tx dispute vote [id] [vote] [flags]
# full example:
./layerd tx dispute vote 3 vote-invalid --from ACCOUNT_NAME --fees 5loya --chain-id layertest-4
```
{% endcode %}

{% code overflow="wrap" %}
```sh
# layerd tx dispute claim-reward [dispute_id] [flags]
./layerd tx dispute claim-reward 2 --from ACCOUNT_NAME --fees 5loya --chain-id layertest-4
```
{% endcode %}

{% code overflow="wrap" %}
```sh
// Some code
```
{% endcode %}

