---
description: Follow the steps to become a Layer testnet validator.
icon: binary-circle-check
---

# Run a Layer Validator (testnet)

## Prerequisites

You will need a [node that's fully synced](broken-reference) and [an account that has a balance](../../running-tellor-layer/manage-accounts.md) (loya).

## Creating your Validator

#### 1) Change directory to `~/layer/binaries/v5.1.1` and check if your address has funds:

{% code overflow="wrap" %}
```bash
cd ~/layer/binaries/v5.1.1 && ./layerd query bank balance YOUR_ACCOUNT_NAME loya
```
{% endcode %}

This outputs something like:

```bash
balance:
  amount: "0"
  denom: loya
```

{% hint style="success" %}
<mark style="color:blue;">**If you need testnet TRB, send us a message in the public**</mark> [<mark style="color:blue;">**Discord**</mark>](https://discord.gg/HX76jMhvG6) <mark style="color:blue;">**(#testing-layer channel)!**</mark> \ <mark style="color:blue;">**Note: You will need to**</mark> [<mark style="color:blue;">**bridge the funds**</mark>](broken-reference) <mark style="color:blue;">**once they are received on Sepolia.**</mark>
{% endhint %}

#### 2)  Retrieve your Node's Pubkey

This is a unique identifier for a node running on your computer:

<pre class="language-bash"><code class="lang-bash"><strong>./layerd comet show-validator
</strong></code></pre>

This returns your validator pubkey.  It should look like this:

```bash
{"@type":"/cosmos.crypto.ed25519.PubKey","key":"FX9cKNl+QmxtLcL926P5yJqZw7YyuSX3HQAZboz3TjM="}
```

Copy this output for the next step.

#### **3) Edit the Validator Configuration File**

Create (or edit) the validator.json file:

```bash
nano validator.json
```

Edit or add the following code:

```json
{
    "pubkey": {"@type":"/cosmos.crypto.ed25519.PubKey","key":"c+EuycPpudgiyVl6guYG9oyPSImHHJz1z0Pg4ODKveo="},
    "amount": "69666420loya",
    "moniker": "yourmoniker",
    "identity": "optional identity signature (ex. UPort or Keybase)",
    "website": "validator's (optional) website",
    "security": "validator's (optional) security contact email",
    "details": "validator's (optional) details",
    "commission-rate": "0.1",
    "commission-max-rate": "0.2",
    "commission-max-change-rate": "0.01",
    "min-self-delegation": "1"
}
```

* Edit `"pubkey"` to match yours from step 4.
* Edit `"amount"` to be the amount of testnet TRB that you would like to stake with 6 decimals and the "loya" denom. (For example: if you want to stake 99 TRB use `"amount": "99000000loya"`)
* Edit `"moniker"` with a name you choose for your validator node.
* Edit identity, website, security, and details with your identifying information. (optional)
* Edit `commission-rate`, `commission-max-rate`, `commission-max-change-rate`, and `min-self-delegation` if desired. (these can be changed later using the `edit-validator` command).

{% hint style="success" %}
<mark style="color:blue;">**Important Considerations for your Validator:**</mark>

* <mark style="color:blue;">When creating your validator, be sure that you are NOT choosing an "amount" that is larger than your balance of test-net TRB.</mark>&#x20;
* <mark style="color:blue;">TRB has 6 decimals: 1 loya is 0.000001 TRB</mark>
* <mark style="color:blue;">Note: TRB tokens are used for gas on the layer network. As a validator / reporter you will need to make transactions to send tokens, become a reporter, unjail, etc. When choosing the amount to stake, it is important to reserve some TRB for gas.</mark>
* <mark style="color:blue;">**Staking on layer is limited to 5% of the total staked tokens per 12 hours. You can check the current amount that's allowed to stake**</mark> [<mark style="color:blue;">**here**</mark>](https://explorer.tellor.io)<mark style="color:blue;">**.**</mark>
{% endhint %}

#### **4)  Create your validator.**

Run the following command to create-validator:

{% code overflow="wrap" %}
```bash
./layerd tx staking create-validator ./validator.json --chain-id tellor-1 --from YOUR_ACCOUNT_NAME --gas 300000 --fees 8loya --yes
```
{% endcode %}

**5) Verify that creation was successful.**

Use the command:

{% code overflow="wrap" %}
```bash
./layerd query staking validator YOUR_ACCOUNT_NAME
```
{% endcode %}

If `status: 3,`you are staked and validating!

{% hint style="info" %}
If `status` is `1`, It means that you are not bonded. This can happen If you accidentally made your "amount" in step 4 too small. Check that you are staking at least 1 TRB (1000000loya).\
\
If `status` is `2`, It means that your validator is jailed. If this happens, check if the node process is running on your host machine.&#x20;
{% endhint %}

You can unjail with steps shown in the [next section.](../../running-tellor-layer/run-the-data-reporter/)
