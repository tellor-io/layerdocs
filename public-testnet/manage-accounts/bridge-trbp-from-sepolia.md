---
description: >-
  Follow the steps to practice bridging Tellor "playground"  TRB (TRBP) from
  Sepolia testnet:
---

# Bridge TRBP from Sepolia

### 1. Mint TRBP ("playground" TRB)

You can mint Layer Testnet TRB using this [Sepolia Tellor Playground](https://sepolia.etherscan.io/address/0x9414151ec45a6e8bdb32b950069577e38a66ee00) contract’s “faucet” command. Connect your wallet, click the function `5. faucet`, put your sepolia ethereum address in the \_user field, click write and confirm your transaction.\


<figure><img src="../../.gitbook/assets/Screenshot 2024-08-13 at 11.36.39 AM.png" alt=""><figcaption><p>Click "Write" and confirm the transaction in your wallet.</p></figcaption></figure>

You should now have 1000 TRBP in your sepolia wallet for bridging to layer.

_Note: TRBP contract address for layer is different from the sepolia TRB token used for reporting to legacy tellor on sepolia._

### 2. Approve the bridge contract

Click on function `2. approve`. \
Set spender to the [bridge contract](https://sepolia.etherscan.io/address/0xFC1C57F1E466605e3Dd40840bC3e7DdAa400528c) address: 0xFC1C57F1E466605e3Dd40840bC3e7DdAa400528c&#x20;

Set \_amount to be the amount that you want to bridge like `25000000000000000000 (25 TRB with 18 decimals)`

<figure><img src="../../.gitbook/assets/Screenshot 2024-08-13 at 9.17.43 AM.png" alt=""><figcaption><p>Click "Write" and confirm the transaction in your wallet.</p></figcaption></figure>

### 3. Make the bridge request (depositToLayer)

Once you have TRBP in your wallet, navigate to the [Layer Testnet bridge](https://sepolia.etherscan.io/address/0xFC1C57F1E466605e3Dd40840bC3e7DdAa400528c#writeContract). Connect your wallet and click function `3. depositToLayer`. Set the amount to the amount of TRBP that you want to bridge, e.g. 100000000000000000000 (100 TRBP + 18 decimals).\
Set \_layerRecipient to your tellor prefix address on layer. If you don't have an address yet, see steps to Create an account on Layer [here](../run-layer/).

<figure><img src="../../.gitbook/assets/Screenshot 2024-08-13 at 11.47.26 AM.png" alt=""><figcaption><p>Click "Write" and confirm the transaction in your wallet.</p></figcaption></figure>

_<mark style="color:red;">Note: The amount that you can bridge is limited. Layer does not allow more than 5% of the supply to be bridged in a 12 hour period. If your tx is failing, try a smaller value for  \_amount.</mark>_

Open your transaction via block explorer and retrieve the `depositId` from the event logs:

<figure><img src="../../.gitbook/assets/Screenshot 2024-08-13 at 12.21.29 PM.png" alt=""><figcaption><p>Click the Logs tab</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/Screenshot 2024-08-13 at 12.21.15 PM.png" alt=""><figcaption><p>Scroll down until you see these lines. Copy all this information for later.</p></figcaption></figure>

### 4. Wait 12 hours

There's a 12 hour delay to secure deposits. While you are waiting, your bridge transaction with me automatically reported to layer. While you're wait it's a great opportunity to join the [tellor discord ](https://discord.gg/tellor)and say hello!

### 5. Claim the Tokens on Layer

Open a terminal on your layer node machine and use the command (replacing 212 your `depositId`):

{% code overflow="wrap" %}
```sh
./layerd tx bridge claim-deposit $TELLOR_ADDRESS 212 0 --from $ACCOUNT_NAME --chain-id layertest-2 --fees 5loya
```
{% endcode %}

You should see your new balance when you run the command:

```sh
./layerd query bank balance $TELLOR_ADDRESS loya --chain-id layertest-2
```

<figure><img src="../../.gitbook/assets/Screenshot 2024-08-13 at 12.27.20 PM.png" alt=""><figcaption></figcaption></figure>
