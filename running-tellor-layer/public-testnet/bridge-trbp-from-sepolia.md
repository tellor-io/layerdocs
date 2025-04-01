---
description: >-
  A polished front-end for bridging is still under construction. Follow the
  steps here to manually bridge Tellor "playground"  TRB (TRBP) from Sepolia
  testnet:
---

# Bridge (test)TRB from Sepolia

#### 1. Mint TRBP ("playground" TRB)

You can mint Layer Testnet TRB using this [Sepolia Tellor Playground](https://sepolia.etherscan.io/address/0x5bd3b87eef3348b2b115a2bc92d8c01aa7a0ceb1) contract’s “faucet” command. Connect your wallet, click the function `5. faucet`, put your sepolia ethereum address in the \_user field, click write and confirm your transaction.\


<figure><img src="../../.gitbook/assets/Screenshot 2024-08-13 at 11.36.39 AM.png" alt=""><figcaption><p>Click "Write" and confirm the transaction in your wallet.</p></figcaption></figure>

You should now have 1000 TRBP in your sepolia wallet for bridging to layer.

_Note: TRBP contract address for layer is different from the sepolia TRB token used for reporting to legacy tellor on sepolia._

#### 2. Approve the bridge contract

Click on function `2. approve`. \
Set spender to the [bridge contract](https://sepolia.etherscan.io/address/0x6ac02f3887b358591b8b2d22cfb1f36fa5843867) address: 0x6ac02F3887B358591b8B2D22CfB1F36Fa5843867&#x20;

Set \_amount to be the amount that you want to bridge like `25000000000000000000 (25 TRB with 18 decimals)`

<figure><img src="../../.gitbook/assets/Screenshot 2024-08-13 at 9.17.43 AM.png" alt=""><figcaption><p>Click "Write" and confirm the transaction in your wallet.</p></figcaption></figure>

#### 3. Make the bridge request (depositToLayer)

Once you have TRBP in your wallet, navigate to the [Layer Testnet bridge](https://sepolia.etherscan.io/address/0x6ac02f3887b358591b8b2d22cfb1f36fa5843867).&#x20;

3.a) Connect your wallet and click function `3. depositToLayer`.&#x20;

3.b) Set the \_amount to the amount of TRBP that you want to bridge, e.g. 10000000000000000000 (10 TRBP + 18 decimals).

_3.c)_ Set the `_tip` to 10000000000000000 (0.01 TRB)

3.d) Set `_layerRecipient` to your tellor prefix address on layer. If you don't have an address yet, see steps to Create an account on Layer [here](manage-accounts.md).

<figure><img src="../../.gitbook/assets/Screenshot 2025-02-06 at 12.22.28 PM (1).png" alt=""><figcaption></figcaption></figure>

Click Write and confirm the transaction.

_<mark style="color:red;">Note: The amount that you can bridge is limited. Layer does not allow more than 5% of the supply to be bridged in a 12 hour period. If your tx is failing, try a smaller value for  \_amount.</mark>_

Open your transaction via block explorer and retrieve the `depositId` from the event logs:

<figure><img src="../../.gitbook/assets/Screenshot 2024-08-13 at 12.21.29 PM.png" alt=""><figcaption><p>Click the Logs tab</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/Screenshot 2024-08-13 at 12.21.15 PM.png" alt=""><figcaption><p>Scroll down until you see these lines. Copy all this information for later.</p></figcaption></figure>

Head to the[ tellor query builder](https://tellor.io/queryidstation/) and generate the query id for your bridge request. Copy the Query ID (see screenshot below). Save this hash for claiming your TRB on layer.&#x20;

<figure><img src="../../.gitbook/assets/Screenshot 2025-02-06 at 12.30.22 PM.png" alt=""><figcaption></figcaption></figure>

#### 4. Wait 12 hours

There's a 12 hour delay to secure deposits. While you are waiting, your bridge transaction with me automatically reported to layer. While you're wait it's a great opportunity to join the [tellor discord ](https://discord.gg/tellor)and say hello!

#### 5. Claim the Tokens on Layer

Open a terminal on your node machine and find the timestamp for the aggregate report for your bridge deposit. The timestamp should be at the bottom of the output:

{% code overflow="wrap" %}
```sh
# Note: remove the '0x' from the beginning of the Query ID
./layerd query oracle get-current-aggregate-report 97e25476d1379dcf4958abe62e2bd81b13adc63d42b908fb1252de268fe365cf
```
{% endcode %}

Open a terminal on your layer node machine and use the command. \
\- Replace YOUR\_TELLOR\_PREFIX\_ADDRESS with your tellor layer address from step 3. \
\- Replace "3" your `depositId` .\
\- Replace 1738788758751 with the timestamp from the command above.&#x20;

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
