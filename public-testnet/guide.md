# Public Testnet Guide

### *Note: This is a guide for setting up a Tellor Layer public testnet validator / reporter. Care is taken to provide info on the tools being used, but testers should be comfortable with running experimental code via command line interface. A beginner’s understanding of the cosmos SDK is highly recommended!*

This guide has three sections:
1. Build and Configure layerd
2. Run a Tellor Layer node.
3. Stake and become a Validator
4. Create a reporter (and unjail if needed)

### Pre-requisites

* A local or cloud system running linux (or mac os with the mac scripts)
* Golang v1.22 (install instrauctions [here](https://go.dev/doc/install))
* jq
* yq
* sed

## Part 1: Build and Configure layerd
There are 7 steps in this part.
1. Clone the Layer repo and change directory to `layer`:

```sh
git clone https://github.com/tellor-io/layer -b public-testnet && cd layer
```

2. **An ethereum RPC is used for reporting tellor bridge transactions.**
Using your favorite text editor, create a file called `secrets.json`:

```sh
nano secrets.json
```

Add this code to the file, replacing `your_api_key` with your Alchemy api key: 

```json
{
"eth_api_key": "your_api_key"
}
```

Close the file with `crtl^x` `y` to save your changes.

3. **Add variables to .bashrc**
Layer needs some information about your setup to be able to run. For the purposes of this guide we will use the following variables:
   * `LAYER_NODE_URL`: Set to the unquoted URL (or public IPv4 address) of a seed node, like tellornode.com.
   * `KEYRING_BACKEND`: Set to `test` by default but can be configured here. (test works fine)
   * `NODE_MONIKER`: Set to whatever you use for the node name + “moniker” at the end (e.g., “billmoniker”).
   * `NODE_NAME`: Set to your name or whatever name you choose (e.g., “bill”).
   * `TELLORNODE_ID`: Set to the unquoted node ID of the seed node.
   * `LAYERD_NODE_HOME`: Should be set to "$HOME/.layer/$NODE_NAME"

It's usually easiest to add them as exports in your `.bashrc` or `zshrc` file so that they are automatically loaded in new windows. Open your `.bashrc` file and add these lines at the end:

```sh
# layer
export LAYER_NODE_URL=54.166.101.67
export TELLORNODE_ID=72a0284c589e1e11823c27580bfbcbaa32a769e7
export KEYRING_BACKEND="test"
export NODE_MONIKER="bobmoniker"
export ACCOUNT_NAME="bob"
export LAYERD_NODE_HOME="$HOME/.layer/$NODE_NAME"
```

*Note: We may need to reset the chain a few more times while we cook. This causes the `TELLORNODE_ID` to change. You can check the current correct id with:*

    ```sh
    curl tellornode.com:26657/status
    ```

4. Create an account on Layer
You will need an account on layer to hold your TRB tokens that you will stake to become a validator reporter.

## Part 2: Run a Layer Node

{% hint style="warning" %}
<mark style="color:blue;">**Note:**</mark> <mark style="color:blue;"></mark><mark style="color:blue;">The test backend is not recommended for production use with real funds. Always handle mnemonics/keys with extreme care, even if it’s just a testnet address.</mark>
{% endhint %}

7. **Important Things to Know Before Running the Script:**
   *   When you start the script (which you haven't done yet),***a test wallet key pair/mnemonic will be created and printed in the terminal. You will need this address to run your validator. There will be a pause allowing you to copy it before it's burried by the node log.*** It will look something like this:

```sh
    - address: tellor1mh2ua3w8yq5ldeewsdhpg0cazhr7gtcllr6j0j
    name: bill
    pubkey: '{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"Ag+lE4VGW6CpE/TiMnb3zJ6pyETVHobj5Bd5F3OuRW7/"}'
    type: local


    **Important** write this mnemonic phrase in a safe place.
    It is the only way to recover your account if you ever forget your password.

    eagle actress venue redacted style redacted potato still redacted final redacted increase redacted parent panda vapor redacted redacted twelve summer redacted redacted redacted redacted
```

*The script should only be run once, or if you want to start over from scratch! It is intended to be used to delete your old chain and to configure the chain and start it all at once (for testing). Once your node is running, it can be restarted with a `./layerd start` command like the last command in start script.*

8. **Run the Script:**
   *   Give the script permission to execute:

     ```sh
    chmod +x layer_scripts/join_chain_new_node_linux.sh
    ```

   *   Run it:

       ```sh
       ./layer_scripts/join_chain_new_node_linux.sh
       ```
   * Wait for the chain to sync. Some errors are expected as the chain starts up, but the log should start moving very quickly once the node starts downloading blocks.

   * Once the log slows down again, it is likely synced. You can verify that your node is synced using:

    ```
    curl localhost:26657/status
    ```

    If `sync_info.catching_up` is `False`, the node is synced! Well done!

## Part 2: Becoming a Validator

Once you have a working node, you can try running a validator and competing for rewards.

You will need to have some layer testnet TRB into your validator account (see step 7 above). Feel free to send a request in the public [discord](https://discord.gg/tellor) #testing-layer channel, or [try the token bridge from the Sepolia testnet playground.](guide.md#getting-testnet-trb)

Keep your node running. Open another window on your layer machine and load up your variables with the values used when your ran the join chain script. Leave the node running, but have it open so that you can use both windows quickly.  Now, set the layer script variables in your new window: 

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

1.  **Verify That You Have a Funded Address:**

```sh
./layerd query bank balance $NODE_NAME loya --chain-id layer
```
2.  **Retrieve Your Validator Public Key:** 
With your `layer` folder as the active directory, use the command:
```sh
./layerd comet show-validator --home $LAYERD_NODE_HOME
```

This returns your validator pubkey (e.g., `{"@type":"/cosmos.crypto.ed25519.PubKey","key":"FX9cKNl+QmxtLcL926P5yJqZw7YyuSX3HQAZboz3TjM="}`).

Note: Your nodes home directory variable `LAYERD_NODE_HOME` needs to be set prior to running ./layerd commands when you're outside the scripts. [You can load variables into all new bash windows by adding the export commands to your shell's .bashrc file](https://unix.stackexchange.com/questions/117467/how-to-permanently-set-environmental-variables) (.zshrc on mac). 

3.  **Edit the Validator Configuration File:** 
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
    - Edit the `"pubkey"` to match yours from step 2. 
    - Edit `"amount"` to be the amount of testnet TRB that you would like to stake with 6 decimals and the "loya" denom. For example if you want to stake 599 TRB: `"amount": "599000000loya"`.
    - Edit `"moniker"` to be the moniker you chose for running your node start script. (this is the "name" of your validator)

    <mark style="color:blue;">**Note:**</mark> <mark style="color:blue;"></mark><mark style="color:blue;">TRB tokens are used for gas on the layer network. As a validator you will need to make transactions to send tokens, become a reporter, unjail, etc. When choosing the amount to stake, it is important to reserve some TRB for gas. </mark>

4.  **Create Your Validator:**
At the time of writing, a few things need to happen (in order) to successfully start a validator. You will need to:
    1. Make the create-validator tx.
    2. Count to 10.
    3. Restart your node using a ./layerd command *not the script*.

    Let's go!
    1. Run the following commands:

        ```sh
        ./layerd tx staking create-validator ./validator.json --from $NODE_NAME --home $LAYERD_NODE_HOME --chain-id layer --node="http://localhost:26657" --gas "400000"
        ```

    2. count to 10
    3. In your node window, use `ctrl^c` to stop the node. Use this command to start it back up:

        ```sh
        ./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false
        ```

5.  **Verify Your Validator Creation:** 
Ensure your validator was created successfully using the command:

    ```sh
    ./layerd query staking validator $(./layerd keys show $NODE_NAME --bech val --address --keyring-backend $KEYRING_BACKEND --home $LAYERD_NODE_HOME) --output json | jq
    ```
    

If status is `3`, you are a validator and you're not jailed. Awesome!
If status is `2`, you created your validator, but it was jailed (it's ok, you can probably unjail later).

## Part 2: Becoming a Reporter (and maybe unjail a little bit...)

Once you’re successfully running a validator, you’re almost a reporter already! Just aone more command:

```sh
./layerd tx reporter create-reporter "100000000000000000" "1000000" --from $NODE_NAME --keyring-backend test --chain-id layer --home $LAYERD_NODE_HOME
```

Restart your node again, but this time we will change the command a bit to turn on the price daemon:

```sh
./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false
```

## Steps to unjail:
Layer testnet is still experimental, and jailing can happen for various reasons while we work out the kinks. Make sure your terminal window (shell) has all the variables loaded before trying to build txs. Read all steps first because you have about 4 minutes to do everything or you will be jailed again for inactivity:

1. stop your node / validator / reporter with and start it back up as a node / validator (turning off the reporter):

    ```
    ./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false
    ```

2. enter the unjail the command:

    ```
    ./layerd tx slashing unjail --from $NODE_NAME --chain-id layer --yes
    ```

3. Restart the node with reporter daemon turned on:

    ```
    ./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false
    ```

### Getting Testnet TRB

You can mint Layer Testnet TRB using the Sepolia Tellor Playground contract’s “faucet” command:\
[https://sepolia.etherscan.io/address/0x3251838bd813fdf6a97D32781e011cce8D225d59#writeContract\
\
](https://sepolia.etherscan.io/address/0x3251838bd813fdf6a97D32781e011cce8D225d59#writeContract)Once you have TRBP in your wallet, head over to the Layer Testnet bridge:\
[https://sepolia.etherscan.io/address/0x7a261EAa9E8033B1337554df59bD462ca4A251FA#writeContract\
](https://sepolia.etherscan.io/address/0x7a261EAa9E8033B1337554df59bD462ca4A251FA#writeContract)
