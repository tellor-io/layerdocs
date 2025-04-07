---
description: Bridge requests can me made at bridge.tellor.io!
---

# Bridging Sepolia TRB

{% hint style="success" %}
If you don't have any Sepolia TRB, Make a request in the [Tellor Discord](https://discord.gg/kaMenz4ZVw)'s `testing-layer` channel.

**Reminder: There is no incentive to run the testnet unless you want to be a validator and /or reporter on mainnet. TRB inflation is immutable.**
{% endhint %}

_**When you make a tellor bridge deposit request, that EVM event is reported on Tellor Layer by the data reporters running there. After a 12 hour wait, the data can be claimed by anyone who wants to claim the tip.**_&#x20;

{% hint style="warning" %}
<mark style="color:blue;">N</mark><mark style="color:blue;">**ote: The amount that you can bridge is limited. Layer does not allow more than 5% of the supply to be bridged in a 12 hour period. If your bridge request is failing, try a smaller value for  \_amount.**</mark>
{% endhint %}

### Navigate to [bridge.tellor.io](https://bridge.tellor.io/)

1\) Click "Connect Wallet" and connect your Ethereum wallet. Make sure that you have some Sepolia TRB and ETH for Gas.&#x20;

<figure><img src="../../.gitbook/assets/Screenshot From 2025-04-03 12-18-53.png" alt=""><figcaption><p>Note: The "Deposit Limit" displayed is the maximum amount of TRB that can be bridged for the current 12 hour period.</p></figcaption></figure>

2\) Fill out the TRB field with the balance of TRB that you want to bridge to Tellor Layer. Fill out the TIP field with the amount of TRB that you would like to tip as a reward for the person who claims your bridge request.

{% hint style="success" %}
<mark style="color:blue;">A tip of 0.01 TRB should work, but larger tips may entice someone to claim your deposit more quickly.</mark>&#x20;
{% endhint %}

4\. Wait 12 hours

While you're wait it's a great opportunity to join the [tellor discord ](https://discord.gg/tellor)and say hello!

{% hint style="success" %}
<mark style="color:blue;">**When 12 hours have passed, your bridge deposit tip becomes claimable on layer. When someone runs claim-deposit for your deposit ID, they can claim the tip.**</mark>
{% endhint %}

5. Wait for their deposit (tip) to be claimed. Those who already have funds on layer can check the next section to learn how to `claim-deposits` !
