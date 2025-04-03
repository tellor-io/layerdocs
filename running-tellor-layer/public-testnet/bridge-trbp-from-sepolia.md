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
At the time of writing, Tellor Layer is still testnet only and a tip of 0.01 TRB works great.
{% endhint %}

4\. Wait 12 hours

There's a 12 hour delay to secure deposits. While you're wait it's a great opportunity to join the [tellor discord ](https://discord.gg/tellor)and say hello!

\
5\. Check if your bridge deposit was successful!&#x20;

You should see your new balance reflected when you run the command:

{% code overflow="wrap" %}
```sh
./layerd query bank balance $TELLOR_ADDRESS loya
```
{% endcode %}

{% hint style="warning" %}
At the time of writing Layer is testnet only. If more than 12 hours have passed, and you don't see the balance reflected in your wallet, feel free to reach out to the tellor team.
{% endhint %}
