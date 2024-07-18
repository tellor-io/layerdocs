# Part 2: Become a Validator

*Once you've got your node running and synced, you're ready to become a validator!*

You will need to have some layer testnet TRB. Feel free to send us your tellor prefixed address / request in the public [discord](https://discord.gg/tellor) #testing-layer channel, or [try the token bridge from the Sepolia testnet playground.](guide.md#getting-testnet-trb)

***Setup Note: Open up another screen or terminal window on your layer machine for doing the validator steps. If you followed the install guide and added the variables to your .bashrc file, you should be able to copy / paste the commands in this documentation to stake your validator.*** 

***It helps to have quick access to the node window and the commands window as you go though the steps (to avoid jailing).***

1.  **Check if your node is synced:**
Run the command

```sh
./layerd status
```

If `"catching_up": true`, your node is not synced.
If `"catching_up": false`, your node is synced!

2. **Check if your address has funds**

```sh
./layerd query bank balance $ACCOUNT_NAME loya --chain-id layer
```

3. While we're at it, let's grab your "tellorvaloper" prefix address also:

```sh
./layerd keys show $ACCOUNT_NAME --bech val --home $LAYERD_NODE_HOME
```

*This will output the "tellorvaloper" prefix address for your account. It is used for validator commands and is different from the "tellor" prefix address that is used for sending and recieving TRB. Copy this "tellorvaloper" prefix address and keep it in the same place where you can copy it later.*

4.  **Retrieve Your Validator Public Key:** 
With your `layer` folder as the active directory, use the command:

```sh
./layerd comet show-validator --home $LAYERD_NODE_HOME
```

This returns your validator pubkey. (e.g., `{"@type":"/cosmos.crypto.ed25519.PubKey","key":"FX9cKNl+QmxtLcL926P5yJqZw7YyuSX3HQAZboz3TjM="}`).
Copy it and keep it in a safe place. You will need it in the next step.

5.  **Edit the Validator Configuration File:** 
Open `~/layer/validator.json`:

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
- Edit `"pubkey"` to match yours from step 2. 
- Edit `"amount"` to be the amount of testnet TRB that you would like to stake with 6 decimals and the "loya" denom. 
    (For example: if you want to stake 99 TRB use `"amount": "99000000loya"`)
- Edit `"moniker"` to match your node moniker variable.

    <mark style="color:blue;">**Note:**</mark> <mark style="color:blue;"></mark><mark style="color:blue;">TRB tokens are used for gas on the layer network. As a validator you will need to make transactions to send tokens, become a reporter, unjail, etc. When choosing the amount to stake, it is important to reserve some TRB for gas. </mark>

6.  **Create Your Validator:**
A few things need to happen (in order) to successfully start a layer validator. You should have two terminal windows open: a command window and a node window.

You will need to do a, b, and c carefully:
a. Do the create-validator tx in command window
b. Count to 10
c. Restart your node in the node window

    Let's go!
    a. Run the following command to create-validator:

        ```sh
        ./layerd tx staking create-validator ./validator.json --from $ACCOUNT_NAME --home $LAYERD_NODE_HOME --chain-id layer --node="http://localhost:26657" --gas "400000" --yes
        ```

    b. count to 10 and open the node window
    c. In your node window, use `ctrl^c` to stop the node. Enter this command to start it back up:

        ```sh
        ./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false
        ```

5.  **Verify Your Validator Creation:** 
Ensure your validator was created successfully using the command:

    ```sh
    ./layerd query staking validator $(./layerd keys show $ACCOUNT_NAME --bech val --address --keyring-backend $KEYRING_BACKEND --home $LAYERD_NODE_HOME)
    ```


If status is `3`, you are a validator and you're not jailed. Awesome!
If status is `2`, you created your validator, but it was jailed (it's ok, you can probably unjail later).

## Part 2: Becoming a Reporter (and maybe unjail a little bit...)

Once you’re successfully running a validator, you’re almost a reporter already! Just aone more command:

```sh
./layerd tx reporter create-reporter "100000000000000000" "1000000" --from $ACCOUNT_NAME --keyring-backend $KEYRING_BACKEND --chain-id layer --home $LAYERD_NODE_HOME
```

Restart your node again, but this time we will change the command a bit to turn on the price daemon:

```sh
./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false
```

## Steps to unjail:
Layer testnet is still experimental, and jailing can happen for various reasons while we work out the kinks. Make sure your terminal window (shell) has all the variables loaded before trying to build txs. Read all steps first because you have about 4 minutes to do everything or you will be jailed again for inactivity:

1. stop your node / validator / reporter with and start it back up as a node / validator (turning off the reporter):

```sh
./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false
```

2. enter the unjail the command:

```sh
./layerd tx slashing unjail --from $ACCOUNT_NAME --chain-id layer --yes
```

3. Restart the node with reporter daemon turned on:

```sh
./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false
```

### Getting Testnet TRB

You can mint Layer Testnet TRB using the Sepolia Tellor Playground contract’s “faucet” command:\
[https://sepolia.etherscan.io/address/0x3251838bd813fdf6a97D32781e011cce8D225d59#writeContract\
\
](https://sepolia.etherscan.io/address/0x3251838bd813fdf6a97D32781e011cce8D225d59#writeContract)Once you have TRBP in your wallet, head over to the Layer Testnet bridge:\
[https://sepolia.etherscan.io/address/0x7a261EAa9E8033B1337554df59bD462ca4A251FA#writeContract\
](https://sepolia.etherscan.io/address/0x7a261EAa9E8033B1337554df59bD462ca4A251FA#writeContract)
