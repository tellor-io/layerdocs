# Becoming a Validator

## Becoming a Validator

Keep your node running. Open another window on your layer machine and load up your variables with the values used when your ran the join chain script. Leave the node running, but have it open so that you can use both windows quickly. Now, set the layer script variables in your new window:

```sh
export LAYER_NODE_URL=54.166.101.67 \
&& export TELLORNODE_ID=9007e2991e7f07a016559aed4685f4ba0619c631 \
&& export KEYRING_BACKEND="test" \
&& export NODE_MONIKER="bobmoniker" \
&& export NODE_NAME="bob" \
&& export AMOUNT_IN_TRB=10000 \
&& export AMOUNT_IN_LOYA="1000000000loya" \
&& export LAYERD_NODE_HOME="$HOME/.layer/$NODE_NAME"
```

Use `printenv` to double check that all the commands are set correctly.

1. **Verify That You Have a Funded Address:**

```sh
./layerd query bank balance $NODE_NAME loya --chain-id layer
```

2. **Retrieve Your Validator Public Key:** With your `layer` folder as the active directory, use the command:

```sh
./layerd comet show-validator --home $LAYERD_NODE_HOME
```

This returns your validator pubkey (e.g., `{"@type":"/cosmos.crypto.ed25519.PubKey","key":"FX9cKNl+QmxtLcL926P5yJqZw7YyuSX3HQAZboz3TjM="}`).

Note: Your nodes home directory variable `LAYERD_NODE_HOME` needs to be set prior to running ./layerd commands when you're outside the scripts. [You can load variables into all new bash windows by adding the export commands to your shell's .bashrc file](https://unix.stackexchange.com/questions/117467/how-to-permanently-set-environmental-variables) (.zshrc on mac).

3.  **Edit the Validator Configuration File:** Open `~/layer/validator.json`:

    ```json
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

    * Edit the `"pubkey"` to match yours from step 2.
    * Edit `"amount"` to be the amount of testnet TRB that you would like to stake with 6 decimals and the "loya" denom. For example if you want to stake 599 TRB: `"amount": "599000000loya"`.
    * Edit `"moniker"` to be the moniker you chose for running your node start script. (this is the "name" of your validator)

    <mark style="color:blue;">**Note:**</mark> <mark style="color:blue;">TRB tokens are used for gas on the layer network. As a validator you will need to make transactions to send tokens, become a reporter, unjail, etc. When choosing the amount to stake, it is important to reserve some TRB for gas.</mark>
4.  **Create Your Validator:** At the time of writing, a few things need to happen (in order) to successfully start a validator. You will need to:

    1. Make the create-validator tx.
    2. Count to 10.
    3. Restart your node using a ./layerd command _not the script_.

    Let's go!

    1.  Run the following commands:

        ```sh
        ./layerd tx staking create-validator ./validator.json --from $NODE_NAME --home $LAYERD_NODE_HOME --chain-id layer --node="http://localhost:26657" --gas "400000"
        ```
    2. count to 10
    3.  In your node window, use `ctrl^c` to stop the node. Use this command to start it back up:

        ```sh
        ./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false
        ```
5.  **Verify Your Validator Creation:** Ensure your validator was created successfully using the command:

    ```sh
    ./layerd query staking validator $(./layerd keys show $NODE_NAME --bech val --address --keyring-backend $KEYRING_BACKEND --home $LAYERD_NODE_HOME) --output json | jq
    ```

If status is `3`, you are a validator and you're not jailed. Awesome! If status is `2`, you created your validator, but it was jailed (it's ok, you can probably unjail later).
