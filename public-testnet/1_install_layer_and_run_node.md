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

2. Build layerd with the command:

```sh
go build ./cmd/layerd
```

3. **An ethereum RPC is used for reporting tellor bridge transactions.**
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

Exit nano with `ctrl^x` then enter `y` to save the changes.

4. **Add variables to .bashrc (or .zshrc)**
*Setting variables in .bashrc is not required, but it helps to avoid many common errors.* 
Here is a list of variables we will use in this guide and a short description of their purpose:
   * `LAYER_NODE_URL`: Set to the unquoted URL (or public IPv4 address) of a seed node, like tellornode.com.
   * `KEYRING_BACKEND`: Set to `test` by default but can be configured here. (test works fine)
   * `NODE_MONIKER`: Set to whatever you'd like to use for your validator's public readable name (e.g "bob").
   * `ACCOUNT_NAME`: Set to your name or whatever name you choose (like “bill” or "ruth").
   * `TELLORNODE_ID`: Set to the unquoted node ID of the seed node.
   * `LAYERD_NODE_HOME`: Should be set to "$HOME/.layer/$ACCOUNT_NAME"
   * `TELLOR_ADDRESS`: the tellor prefix address for your account
   * `TELLORVALOPER_ADDRESS`: the tellorvaloper prefix address for your account

Open your `.bashrc` or `zshrc` file:

```sh
nano ~/.bashrc # if linux
nano ~/.zshrc # if mac
```

Add these lines at the end, editing `NODE_MONIKER` be to whatever you'd like to name your node. Edit the ACCOUNT_NAME to whatever you'd like to call your wallet account:

```sh
# layer
export LAYER_NODE_URL=54.166.101.67
export TELLORNODE_ID=72a0284c589e1e11823c27580bfbcbaa32a769e7
export KEYRING_BACKEND="test"
export NODE_MONIKER="bobmoniker"
export ACCOUNT_NAME="bob"
export LAYERD_NODE_HOME="$HOME/.layer/$ACCOUNT_NAME"
export TELLOR_ADDRESS= # your tellor prefix address (we will add it later)
export TELLORVALOPER_ADDRESS= #your tellorvaloper address (we will add it later)
```

Exit nano with `ctrl^x` then enter `y` to save the changes.

Restart your terminal, or use `source ~/.bashrc` before you continue. (if Linux)
Restart your terminal, or use `source ~/.zshrc` before you continue. (if mac)

*Note: We may need to reset the chain a few more times while we cook. This causes the `TELLORNODE_ID` to change. You can check the current correct id with:*

```sh
curl tellornode.com:26657/status
```

4. **Initialize config folders**

```sh
./layerd init layer --chain-id layer
```

5. **Initialize a named config folder**

```sh
./layerd init $ACCOUNT_NAME --chain-id layer --home ~/.layer/$ACCOUNT_NAME
```

5. **Create an account on Layer**
You will need a "wallet" account on layer to hold your TRB tokens that you will stake to become a validator reporter.

<mark style="color:blue;">**Security Tips:**</mark> <mark style="color:blue;"></mark><mark style="color:blue;">1. The test backend is not recommended for production use with real funds because the keys are stored as plain text. Always use a secure keyring-backend option for real funds! 2. Handle mnemonics/keys with extreme care, even if it’s just a testnet address! 3. Never use an address that holds real mainnet funds for testing!</mark>

You can check accounts any time with:

```sh
./layerd keys list --keyring-backend $KEYRING_BACKEND --home $LAYERD_NODE_HOME
```

**If you do not yet have an account / mnemonic**
Generate a new key pair with the command:

```sh
./layerd keys add $ACCOUNT_NAME --keyring-backend $KEYRING_BACKEND --home $LAYERD_NODE_HOME
```
**Be sure to copy the entire output with the mnemonic and keep it in a very safe place!**

**If you already have an account / pnemonic**
Import your account with the command:
(You will be prompted to input your mnemonic)

```sh
./layerd keys add $ACCOUNT_NAME --recover=true --keyring-backend $KEYRING_BACKEND --home $LAYERD_NODE_HOME
``` 

6. **Add your address to your ~/.bashrc or .zshrc file**
Open it with:

```sh
nano ~/.bashrc # if linux
nano ~/.zshrc # if mac
```

set TELLOR_ADDRESS to your tellor prefix address like:

```sh
export TELLOR_ADDRESS=tellor1asdfc5cqnt68k376g7fvasdfh6w4qy9et6asdf
```

Exit nano with `ctrl^x` then enter `y` to save the changes.

7. **Create and Run the configure_layer script**
We need to change the config files a bit using one of the provided `configure_layer_nix.sh` or `configure_layer_mac.sh` scripts from the layerdocs repo.

**If on linux:**
- Navigate [here](https://raw.githubusercontent.com/tellor-io/layerdocs/update-guide-working/public-testnet/configure_layer_nix.sh), select all and copy the code to your clipboard. 

- create the script file locally:

```sh
nano configure_layer_nix.sh # or configure_layer_mac.sh if mac
```

Paste the code, then exit nano with `ctrl^x` then enter `y` to save the changes.

**If on Mac:**
- Navigate [here](https://raw.githubusercontent.com/tellor-io/layerdocs/update-guide-working/public-testnet/configure_layer_mac.sh), select all and copy the code to your clipboard. 

- create the script file locally:

```sh
nano configure_layer_mac.sh # or configure_layer_mac.sh if mac
```

Paste the code, then exit nano with `ctrl^x` then enter `y` to save the changes.

Give your new script permission to execute and run it to replace the default configs with proper layer chain configs:

```sh
chmod +x configure_layer_nix.sh && ./configure_layer_nix.sh #if linux
chmod +x configure_layer_mac.sh && ./configure_layer_mac.sh #if mac
```

## Start your Layer Node!

***Before starting your node, it's a good idea to think about how you want to run it so that the process does not get killed accidentally. [GNU screen](https://tellor.io/blog/how-to-manage-cli-applications-on-hosted-vms-with-screen/) is a great option for beginners. More advanced setups can be achieved using systemd.***

Run the command:

```sh
./layerd start --api.swagger --price-daemon-enabled=false --home $LAYERD_NODE_HOME
```

If your node is configured correctly, you should see the node connecting to endopoints before rapidly downloading blocks. congrats!

