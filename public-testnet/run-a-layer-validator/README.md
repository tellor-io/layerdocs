---
description: Follow the steps to become a Layer testnet validator.
---

# Run a Layer Validator

{% hint style="success" %}
<mark style="color:green;">**You will need a node that's fully synced and an account that has a balance (loya).**</mark>  \
See our [instructions on getting testnet TRB for help.](../run-layer/bridge-trbp-from-sepolia.md)&#x20;
{% endhint %}

## Validator Setup

1. **Check if your address has funds:**

```bash
./layerd query bank balance $ACCOUNT_NAME loya
```

This outputs something like:

```bash
balance:
  amount: "0"
  denom: loya
```

If you need testnet TRB, see the [Getting Testnet TRB](../run-layer/bridge-trbp-from-sepolia.md) section!

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

{% hint style="warning" %}
<mark style="color:red;">**These next steps are time sensitive so do them carefully:**</mark>&#x20;

* Do the create-validator tx in command window
* Count to 10&#x20;
* Restart your node in the node window
{% endhint %}

* Run the following command to create-validator:

{% code overflow="wrap" %}
```bash
./layerd tx staking create-validator ./validator.json --from $TELLOR_ADDRESS --chain-id layertest-1 --fees 1000loya
```
{% endcode %}

* **count to 10** as you open the node window.
* In your node window, use `ctrl^c` to stop the node. Enter this command to start it back up:

{% code overflow="wrap" %}
```bash
./layerd start --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false --home $HOME/.layer --key-name $ACCOUNT_NAME
```
{% endcode %}

6. **Verify Your Validator Creation**\
   Ensure your validator was created successfully using the command replacing your\_validator\_address:

{% code overflow="wrap" %}
```bash
./layerd query staking validator $TELLORVALOPER_ADDRESS --chain-id layertest-1
```
{% endcode %}

If status is `3`...awesome! \
If status is `2`...still great!\
\
If your status is 2, that means that somehow in the process of making your validator you got jailed. It's ok! You can unjail with steps shown in the [next section.](../create-a-reporter.md)
