---
description: Lock your TRB on Ethereum, receive funds on tellor
icon: bridge-lock
---

# Bridging TRB

### Prerequisites

* &#x20;Ethereum wallet with [TRB](https://etherscan.io/token/0x88df592f8eb5d7bd38bfef7deb0fbc02cf3778a0?a=0x8cfc184c877154a8f9ffe0fe75649dbe5e2dbebf).
* A [recieving address](../running-tellor/manage-accounts.md) on Tellor layer.

### How to Deposit:

Navigate to [hub.tellor.io](https://hub.tellor.io/).

Click the "bridge" circle. Then click "Connect Wallet" and connect your Ethereum wallet. (screenshot below)

Fill out the "TRB" field with the amount that you want to bridge to Tellor. Fill in the "to address" field with your tellor prefix account and approve the transaction in your wallet extension pop-up.

<figure><img src="../.gitbook/assets/Screenshot From 2025-11-17 11-10-47.png" alt=""><figcaption></figcaption></figure>

Click "Approve Deposit" and sign the proposed transaction with your ethereum wallet, then click "Bridge to Tellor" and do the same.

**After a 12 hour security delay, your balance of TRB will arrive in your tellor wallet automatically.** Congrats! This is a great time to pop into the [tellor discord ](https://discord.gg/tellor)and say hello!

### How to Withdraw (bridge back to Ethereum):

Navigate to [hub.tellor.io](https://hub.tellor.io/).

Click the "bridge" circle. Click "Connect Wallets" to connect your Ethereum wallet and your keplr wallet. (The keplr wallet must be the one that holds your funds on Tellor Layer.) \
\
Then also click "To Ethereum" as shown in the screenshot below.

<figure><img src="../.gitbook/assets/Screenshot From 2025-11-17 11-21-04.png" alt=""><figcaption></figcaption></figure>

Fill in the fields with your ethereum address and the amount of TRB that you would like to withdraw Click "Request Withdrawal" and sign the transaction with keplr. \
\
Wait 12 hours.

After 12 hours have passed, connect your wallets again (if necessary) and you should see two buttons next to your withdrawal details in the Withdrawal Transactions table.

<figure><img src="../.gitbook/assets/Screenshot From 2025-11-17 11-16-51.png" alt="" width="323"><figcaption></figcaption></figure>

Click "Request attestation" and sign the tx with your keplr wallet.\
Click "Claim Withdrawal" and sign the tx with your ethereum wallet. The funds should arrive immediately.

### Backup Method:

If the bridge page is ever unavailable, use etherscan.

{% content-ref url="etherscan-method-deposits.md" %}
[etherscan-method-deposits.md](etherscan-method-deposits.md)
{% endcontent-ref %}

If you want to make a bridge request using the layerd CLI:

{% content-ref url="request-a-withdrawal-via-cli.md" %}
[request-a-withdrawal-via-cli.md](request-a-withdrawal-via-cli.md)
{% endcontent-ref %}
