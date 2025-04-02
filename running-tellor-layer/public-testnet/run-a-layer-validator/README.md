---
description: Follow the steps to become a Layer testnet validator.
---

# Run a Layer Validator

{% hint style="success" %}
<mark style="color:green;">**You will need a node that's fully synced and an account that has a balance (loya).**</mark>  \
See our [instructions on getting testnet TRB for help.](../bridge-trbp-from-sepolia.md)&#x20;
{% endhint %}

## Validator Setup

_**You will need a fully synced node to use as your validator. If you don't have one, start**_ [_**here**_](../node-setup/)_**.**_

1. **Open up a new terminal window on your node machine and check if your address has funds:**

```bash
./layerd query bank balance YOUR_ACCOUNT_NAME loya
```

This outputs something like:

```bash
balance:
  amount: "0"
  denom: loya
```

{% hint style="info" %}
If you need testnet TRB, send us a message in the [Discord](https://discord.gg/HX76jMhvG6)! You can also [bridge it yourself](../bridge-trbp-from-sepolia.md) with a 12 hour delay.
{% endhint %}

3. **Retrieve Your Validator Public Key**\
   With your `layer` folder as the active directory, use the command:

```bash
./layerd comet show-validator
```

This returns your validator pubkey.  Should look like this:

```bash
{"@type":"/cosmos.crypto.ed25519.PubKey","key":"FX9cKNl+QmxtLcL926P5yJqZw7YyuSX3HQAZboz3TjM="}
```

Copy the pubkey to your clipboard for step 4.

4. **Edit the Validator Configuration File**

Create (or edit) the validator.json file:

```bash
nano validator.json
```

{% hint style="warning" %}
* <mark style="color:blue;">**When creating your validator, be sure that you are not choosing an "amount" that is larger than your balance of test-net TRB.**</mark>&#x20;
* <mark style="color:blue;">**Keep some funds available for paying gas fees if you're going to be running the data reporter.**</mark>
* <mark style="color:blue;">**TRB has 6 decimals: 1 loya is 0.000001 TRB**</mark>
{% endhint %}

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

{% hint style="info" %}
<mark style="color:blue;">**Note:**</mark> TRB tokens are used for gas on the layer network. As a validator you will need to make transactions to send tokens, become a reporter, unjail, etc. When choosing the amount to stake, it is important to reserve some TRB for gas.
{% endhint %}

5. **Create Your Validator:** A few things need to happen (in order) to successfully start a layer validator. You should have two terminal windows open: a command window and a node window.

{% hint style="info" %}
<mark style="color:blue;">**Staking on layer is limited to 5% of the total staked tokens per 12 hours. You can check the current amount that's allowed to stake**</mark> [<mark style="color:blue;">**here**</mark>](https://antietam.tellor.io/)<mark style="color:blue;">**.**</mark>
{% endhint %}

Run the following command to create-validator:

{% code overflow="wrap" %}
```bash
./layerd tx staking create-validator ./validator.json --chain-id layertest-4 --from YOUR_ACCOUNT_NAME --fees 5loya --yes
```
{% endcode %}

6. Restart your node, adding the --key-name flag. Head back to the terminal where you're running your node and use ctrl^c to stop it. Then use the command:

```sh
./layerd start --price-daemon-enabled=false --home ~/.layer --key-name YOUR_ACCOUNT_NAME
```

You should see the log quickly catch up. Are you a validator now?

6. **Verify Your Validator Creation**\
   Ensure your validator was created successfully using the command replacing your\_validator\_address:

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

You can unjail with steps shown in the [next section.](../run-the-data-reporter.md)
