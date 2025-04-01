---
description: >-
  Follow the steps here to manually bridge Tellor "playground"  TRB (TRBP) from
  Sepolia testnet:
---

# Bridging Sepolia TRB

#### 1. Approve the bridge contract

Navigate to the [Sepolia TRB contract](https://sepolia.etherscan.io/address/0x80fc34a2f9FfE86F41580F47368289C402DEc660#writeProxyContract): 0x80fc34a2f9FfE86F41580F47368289C402DEc660\


On the Contracts tab, click on function `2. approve`. Set spender to the [bridge contract](https://sepolia.etherscan.io/address/0x5acb5977f35b1A91C4fE0F4386eB669E046776F2) address: 0x5acb5977f35b1A91C4fE0F4386eB669E046776F2&#x20;

Set \_amount to be the amount that you want to bridge like `25000000000000000000 (25 TRB with 18 decimals)`

<figure><img src="../../.gitbook/assets/Screenshot 2024-08-13 at 9.17.43 AM.png" alt=""><figcaption><p>Click "Write" and confirm the transaction in your wallet.</p></figcaption></figure>

#### 3. Make the bridge request (depositToLayer)

Once you have TRBP in your wallet, navigate to the [Layer Testnet bridge](https://sepolia.etherscan.io/address/0x5acb5977f35b1A91C4fE0F4386eB669E046776F2#writeContract).&#x20;

Connect your wallet and click function `3. depositToLayer`.&#x20;

Set the \_amount to the amount of TRBP that you want to bridge, e.g. 10000000000000000000 (10 TRBP + 18 decimals).

Set the `_tip` to 10000000000000000 (0.01 TRB). This is a tip that can be claimed by any validator or reporter over on layer who is willing to pay the gas to claim your bridge request for you!

Set `_layerRecipient` to your tellor prefix address on layer. If you don't have an address yet, see steps to Create an account on Layer [here](manage-accounts.md).

<figure><img src="../../.gitbook/assets/Screenshot 2025-02-06 at 12.22.28 PM (1).png" alt=""><figcaption></figcaption></figure>

Click Write and confirm the transaction.

_<mark style="color:red;">Note: The amount that you can bridge is limited. Layer does not allow more than 5% of the supply to be bridged in a 12 hour period. If your tx is failing, try a smaller value for  \_amount.</mark>_

#### 4. Wait 12 hours

There's a 12 hour delay to secure deposits. While you're wait it's a great opportunity to join the [tellor discord ](https://discord.gg/tellor)and say hello!

### How to claim tokens on Layer

On layer, the tips for bridge deposit claims become available 12 hours after the bridge request was reported. \
\
If you have some gas in your wallet (at least 100loya) Open a terminal on your node machine and find the timestamp for the aggregate report for the bridge deposit. The timestamp should be at the bottom of the output:

{% code overflow="wrap" %}
```sh
# Note: remove the '0x' from the beginning of the Query ID
./layerd query oracle get-current-aggregate-report 97e25476d1379dcf4958abe62e2bd81b13adc63d42b908fb1252de268fe365cf
```
{% endcode %}

Open a terminal on your layer node machine and use the command. \
\- Replace YOUR\_TELLOR\_PREFIX\_ADDRESS with your tellor layer address from step 3. \
\- Replace "3" your `depositId` .\
\- Replace 1738788758751 with the timestamp from the command above.

{% code overflow="wrap" %}
```sh
./layerd tx bridge claim-deposits YOUR_TELLOR_PREFIX_ADDRESS 3 1738788758751 --from $ACCOUNT_NAME --fees 5loya --yes
```
{% endcode %}

You should see your new balance when you run the command:

```sh
./layerd query bank balance $TELLOR_ADDRESS loya --chain-id layertest-3
```

<figure><img src="../../.gitbook/assets/Screenshot 2024-08-13 at 12.27.20 PM.png" alt=""><figcaption></figcaption></figure>
