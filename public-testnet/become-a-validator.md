# Become a Validator

**Once you've got your node running and synced, you're ready to become a validator!**

{% hint style="success" %}
<mark style="color:green;">**You will need to have some layer testnet TRB.**</mark>  See our [instructions on getting testnet TRB for help.](getting-testnet-trb.md)
{% endhint %}

{% hint style="info" %}
_<mark style="color:blue;">**Setup Note:**</mark>_ _Open up another screen or terminal window on your layer machine for doing the validator steps. If you followed the install guide and added the variables to your .bashrc or .zshrc file, you should be able to copy / paste the commands in this documentation to stake your validator._

_It helps to have quick access to the node window and the commands window as you go though the steps (to avoid jailing)._
{% endhint %}

## Validator Setup

1. **Check if your node is synced:** Run the command

```
./layerd status
```

If `"catching_up": true`, your node is not synced. If `"catching_up": false`, your node is synced!

2. **Check if your address has funds**

```
./layerd query bank balance $TELLOR_ADDRESS loya --chain-id layer
```

3. Output your "tellorvaloper" prefix address also:

```
./layerd keys show $ACCOUNT_NAME --bech val --home $LAYERD_NODE_HOME
```

{% hint style="info" %}
The "tellorvaloper" prefix address for your account is used for validator commands and is different from the "tellor" prefix address that is used for sending and recieving TRB. \
<mark style="color:blue;">**Copy**</mark><mark style="color:blue;">** **</mark>_<mark style="color:blue;">**this "tellorvaloper" prefix address and keep it in the same place where you can find it later.**</mark>_
{% endhint %}

4. **Add your tellorvaloper address to your \~/.bashrc or .zshrc file**\
   Open it with:

```
nano ~/.bashrc # if linux
nano ~/.zshrc # if mac
```

Set TELLORVALOPER\_ADDRESS to your tellor prefix address like:

```
export TELLORVALOPER_ADDRESS=tellorvaloper1asdfc5cqnasdf376g7fv9whph6w4qy9e74asdf
```

Exit nano with `ctrl^x` then enter `y` to save the changes.

5. **Retrieve Your Validator Public Key**\
   With your `layer` folder as the active directory, use the command:

```
./layerd comet show-validator --home $LAYERD_NODE_HOME
```

This returns your validator pubkey. (e.g., `{"@type":"/cosmos.crypto.ed25519.PubKey","key":"FX9cKNl+QmxtLcL926P5yJqZw7YyuSX3HQAZboz3TjM="}`). Copy it and keep it in a safe place. You will need it in the next step.

6.  **Edit the Validator Configuration File**\
    Open `~/layer/validator.json`:

    ```
    {
        "pubkey": {"@type":"/cosmos.crypto.ed25519.PubKey","key":"c+EuycPpudgiyVl6guYG9oyPSImHHJz1z0Pg4ODKveo="},
        "amount": "100000000000loya",
        "moniker": "billmoniker",
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
* Edit `"moniker"` to match your node moniker variable.

{% hint style="info" %}
<mark style="color:blue;">**Note:**</mark> TRB tokens are used for gas on the layer network. As a validator you will need to make transactions to send tokens, become a reporter, unjail, etc. When choosing the amount to stake, it is important to reserve some TRB for gas.
{% endhint %}

7. **Create Your Validator:** A few things need to happen (in order) to successfully start a layer validator. You should have two terminal windows open: a command window and a node window.

{% hint style="warning" %}
<mark style="color:red;">**These next steps are time sensitive so do them carefully:**</mark>&#x20;

* Do the create-validator tx in command window
* Count to 10&#x20;
* Restart your node in the node window
{% endhint %}

* Run the following command to create-validator:

```
./layerd tx reporter create-reporter "100000000000000000" "1000000" --from $ACCOUNT_NAME --keyring-backend $KEYRING_BACKEND --chain-id layer --home $LAYERD_NODE_HOME --keyring-dir $LAYERD_NODE_HOME
```

* **count to 10** and open the node window
* In your node window, use `ctrl^c` to stop the node. Enter this command to start it back up:

```
./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false
```

8.  **Verify Your Validator Creation**\
    Ensure your validator was created successfully using the command:

    ```
    ./layerd query staking validator $(./layerd keys show $ACCOUNT_NAME --bech val --address --keyring-backend $KEYRING_BACKEND --home $LAYERD_NODE_HOME)
    ```

If status is `3`, you are a validator and you're not jailed. Awesome! If status is `2`, you created your validator, but it was jailed (it's ok, you can probably unjail later).
