---
description: How to use Etherscan to bridge Sepolia TRB to Tellor Layer.
---

# Block Explorer Method

_**Bridge requests can usually be sent to layer via**_ [_**https://bridge.tellor.io/**_](https://bridge.tellor.io/)_**. A block explorer can be used as a secondary method using the steps shown below.**_

### 1. Approve the bridge contract

Navigate to the [Sepolia TRB contract](https://sepolia.etherscan.io/address/0x80fc34a2f9FfE86F41580F47368289C402DEc660#writeProxyContract): 0x80fc34a2f9FfE86F41580F47368289C402DEc660

On the Contracts tab, click on function `2. approve`. Set spender to the [bridge contract](https://sepolia.etherscan.io/address/0x5acb5977f35b1A91C4fE0F4386eB669E046776F2) address: 0x5acb5977f35b1A91C4fE0F4386eB669E046776F2

Set \_amount to be the amount that you want to bridge like `25000000000000000000 (25 TRB with 18 decimals)`

![](https://docs.tellor.io/~gitbook/image?url=https%3A%2F%2F2729899787-files.gitbook.io%2F%7E%2Ffiles%2Fv0%2Fb%2Fgitbook-x-prod.appspot.com%2Fo%2Fspaces%252Fs90SVtIdiQ8dmMsqriIa%252Fuploads%252FhbWX6hiZJ1Ve5TF1gqUI%252FScreenshot%25202024-08-13%2520at%25209.17.43%25E2%2580%25AFAM.png%3Falt%3Dmedia%26token%3D982b3c3b-ac73-4e53-a17e-8733b30a8ddd\&width=768\&dpr=4\&quality=100\&sign=b9223cc2\&sv=2)

Click "Write" and confirm the transaction in your wallet. (old contract address in picture)

### 2. Make the bridge request (depositToLayer)

Navigate to the [Layer Testnet bridge](https://sepolia.etherscan.io/address/0x5acb5977f35b1A91C4fE0F4386eB669E046776F2#writeContract).

Connect your wallet and click function `3. depositToLayer`.

Set the \_amount to the amount of TRBP that you want to bridge, e.g. 10000000000000000000 (10 TRBP + 18 decimals).

Set the `_tip` to 10000000000000000 (0.01 TRB). This is a tip that can be claimed by any validator or reporter over on layer who is willing to pay the gas to claim your bridge request for you!

Set `_layerRecipient` to your tellor prefix address on layer. If you don't have an address yet, see steps to Create an account on Layer [here](https://docs.tellor.io/layer-docs/running-tellor-layer/public-testnet/manage-accounts).

![](https://docs.tellor.io/~gitbook/image?url=https%3A%2F%2F2729899787-files.gitbook.io%2F%7E%2Ffiles%2Fv0%2Fb%2Fgitbook-x-prod.appspot.com%2Fo%2Fspaces%252Fs90SVtIdiQ8dmMsqriIa%252Fuploads%252FTWQVieJBEBj2jfPXa887%252FScreenshot%25202025-02-06%2520at%252012.22.28%25E2%2580%25AFPM.png%3Falt%3Dmedia%26token%3D4c9762d2-d0fe-49fe-a9be-88c175e63614\&width=768\&dpr=4\&quality=100\&sign=92b3f40e\&sv=2)

Click Write and confirm the transaction.

Note: The amount that you can bridge is limited. Layer does not allow more than 5% of the supply to be bridged in a 12 hour period. If your bridge request is failing, try a smaller value for \_amount.
