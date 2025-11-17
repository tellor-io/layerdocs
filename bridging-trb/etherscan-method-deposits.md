---
description: How to use Etherscan to "manually" bridge TRB to Tellor Layer.
---

# Etherscan Method (Deposits)

_**Bridge requests can usually be sent to Tellor via**_ [_**https://hub.tellor.io/**_](https://hub.tellor.io/)_**. A block explorer can be used as a secondary method using the steps shown below.**_

### 1. Approve the bridge contract

Navigate to the TRB [contract](trbbridge-contracts-reference.md)'s contract tab. Click the button for "Write as Proxy" (image below)

<figure><img src="../.gitbook/assets/Screenshot From 2025-11-17 12-15-14.png" alt=""><figcaption></figcaption></figure>

On the Contracts tab, click on function `2. approve`\
Set spender to be the [bridge contract address](trbbridge-contracts-reference.md).

Set the `_amount` to be the amount that you want to bridge e.g. `25000000000000000000 (25 TRB with 18 decimals)`

Click "Write" and confirm the transaction in your wallet.

### 2. Make the bridge request (depositToLayer)

Navigate to the [TRBBridge contract](trbbridge-contracts-reference.md)'s contract tab. Click the button for "Write as Proxy".

Connect your wallet and click function `3. depositToLayer`.

Set the \_amount to the amount of TRBP that you want to bridge, e.g. 10000000000000000000 (10 TRBP + 18 decimals).

Set the `_tip` to 10000000000000000 (0.01 TRB). This is a tip that can be claimed by any validator or reporter over on layer who is willing to pay the gas to claim your bridge request for you!

Set `_layerRecipient` to your tellor prefix address on layer. If you don't have an address yet, see steps to Create an account on Layer [here](https://docs.tellor.io/layer-docs/running-tellor-layer/public-testnet/manage-accounts).

<figure><img src="https://docs.tellor.io/~gitbook/image?url=https%3A%2F%2F2729899787-files.gitbook.io%2F%7E%2Ffiles%2Fv0%2Fb%2Fgitbook-x-prod.appspot.com%2Fo%2Fspaces%252Fs90SVtIdiQ8dmMsqriIa%252Fuploads%252FTWQVieJBEBj2jfPXa887%252FScreenshot%25202025-02-06%2520at%252012.22.28%25E2%2580%25AFPM.png%3Falt%3Dmedia%26token%3D4c9762d2-d0fe-49fe-a9be-88c175e63614&#x26;width=768&#x26;dpr=4&#x26;quality=100&#x26;sign=92b3f40e&#x26;sv=2" alt=""><figcaption></figcaption></figure>

Click Write and confirm the transaction.

### 3. Wait 12 Hours

There's a 12 hour delay to secure deposits. While you're wait it's a great opportunity to join the [tellor discord ](https://discord.gg/tellor)and say hello! After 12 hours have passed, your tokens should arrive in your wallet automatically.
