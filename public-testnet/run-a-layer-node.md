# Run a Layer Node

### Pre-requisites

* A local or cloud system running linux, or macOS. If on windows, use WSL. \
  Minimum system specs (at time of writing):\
  \- quad-core cpu\
  \- 8gb ram\
  \- 128gb-2tb nvme storage depending on how you will run your node
* Golang v1.22 (install instrauctions [here](https://go.dev/doc/install))
* jq (`sudo apt install jq` on linux, or `brew install jq` on mac)
* sed (`sudo apt install sed` on linux, or `brew install sed` on mac)

{% hint style="info" %}
<mark style="color:blue;">Here is a list of variables we will set starting in step 4 (refer to these descriptions as needed):</mark>

* `LAYER_NODE_URL`: Set to the unquoted URL (or public IPv4 address) of a seed node, like tellornode.com.
* `KEYRING_BACKEND`: Set to `test` by default but can be configured here. (test works fine)
* `NODE_MONIKER`: Set to whatever you'd like to use for your validator's public readable name (e.g "bob").
* `ACCOUNT_NAME`: Set to your name or whatever name you choose (like “bill” or "ruth").
* `TELLORNODE_ID`: Set to the unquoted node ID of the seed node.
* `LAYERD_NODE_HOME`: Should be set to "$HOME/.layer/$ACCOUNT\_NAME"
* `TELLOR_ADDRESS`: the tellor prefix address for your account
* `TELLORVALOPER_ADDRESS`: the tellorvaloper prefix address for your account
{% endhint %}

## Initial Setup&#x20;

### Build and Configure layerd

There are 9 steps in this part.

1. **Clone the Layer repo, change directory to `layer.:`**

```sh
git clone https://github.com/tellor-io/layer -b v0.5.0 && cd layer
```

2. **Build layerd with the command:**

```sh
go build ./cmd/layerd
```

3. **An ethereum RPC is used for reporting tellor bridge transactions**\
   Using your favorite text editor, create a file called `secrets.yaml`:

```sh
nano secrets.yaml
```

Add this code to the file, replacing \`your\_sepolia\_testnet\_rpc\_url\` with the url of a reliable sepolia rpc:

```json
eth_rpc_url: "wss://your_sepolia_testnet_rpc_url"
```

Exit nano with `ctrl^x` then enter `y` to save the changes.

4. **Add variables to .bashrc (or .zshrc)**\
   _Setting variables in .bashrc or .zshrc is not required, but it helps to avoid many common errors._&#x20;

Open your `.bashrc` or `.zshrc` file:

```sh
nano ~/.bashrc # if linux
nano ~/.zshrc # if mac
```

Add these lines at the end, editing `NODE_MONIKER` be to whatever you'd like to name your node. Edit the ACCOUNT\_NAME to whatever you'd like to call your wallet account:

```sh
# layer
export LAYER_NODE_URL=tellorlayer.com
export TELLORNODE_ID=18f58b3bc1756ad3872b00b349429fd4f56d2b34
export KEYRING_BACKEND="test"
export NODE_MONIKER="bobmoniker"
export ACCOUNT_NAME="bob"
export LAYERD_NODE_HOME="$HOME/.layer/$ACCOUNT_NAME"
```

Exit nano with `ctrl^x` then enter `y` to save the changes.\
\
Restart your terminal, or use `source ~/.bashrc` before you continue. (if Linux) Restart your terminal, or use `source ~/.zshrc` before you continue. (if mac)

_Note: We may need to reset the chain again as we are still cooking. This causes the_ \
_`TELLORNODE_ID` to change. You can check the current correct id with:_

<pre class="language-sh"><code class="lang-sh"><strong>curl tellorlayer.com:26657/status
</strong></code></pre>

5. **Initialize .layer folder in your home directory**

{% code fullWidth="false" %}
```sh
./layerd init layer --chain-id layertest-1
```
{% endcode %}

6.  **Create and Run the configure\_layer script**\
    We need to change the config files a bit using one of the provided `configure_layer_nix.sh` or `configure_layer_mac.sh` scripts from the layerdocs repo.

    **If on linux:**

    * create the script file locally:

    ```sh
    nano configure_layer_nix.sh # or configure_layer_mac.sh if mac
    ```

    * Navigate [here](https://raw.githubusercontent.com/tellor-io/layerdocs/update-guide-working/public-testnet/configure\_layer\_nix.sh), select all and copy the code to your clipboard.&#x20;
    * Paste the code, then exit nano with `ctrl^x` then enter `y` to save the changes.

    **If on Mac:**

    * create the script file locally:

    ```sh
    nano configure_layer_mac.sh # or configure_layer_mac.sh if mac
    ```

    * Navigate [here](https://raw.githubusercontent.com/tellor-io/layerdocs/update-guide-working/public-testnet/configure\_layer\_mac.sh), select all and copy the code to your clipboard.
    * Paste the code, then exit nano with `ctrl^x` then enter `y` to save the changes.

    Give your new script permission to execute and run it to replace the default configs with proper layer chain configs:

    ```sh
    chmod +x configure_layer_nix.sh && ./configure_layer_nix.sh #if linux
    chmod +x configure_layer_mac.sh && ./configure_layer_mac.sh #if mac
    ```

    You're now ready to start your node with default sync settings. If you want to do a state sync, do the additional config steps [here](how-to-use-state-sync.md) before you continue.&#x20;
7. **Create an account on Layer**\
   You will need a "wallet" account on layer to hold your TRB tokens that you will stake to become a validator reporter.

{% hint style="info" %}
<mark style="color:blue;">**Security Tips:**</mark> \
1\. This guide uses the "test" backend because this is a testnet guide. Always use a secure [keyring-backend option like os, file, or pass](https://docs.cosmos.network/v0.46/run-node/keyring.html) if you're handling real money! \
2\. Handle mnemonics/keys with extreme care, even if it’s just a testnet address! \
3\. Never use an address that holds real "mainnet" funds for testing!
{% endhint %}

If you do not yet have an account / mnemonic phrase, Generate a new key pair with the command:

```sh
./layerd keys add $ACCOUNT_NAME
```

{% hint style="warning" %}
Be sure to <mark style="color:orange;">**copy the entire output**</mark> with the mnemonic and keep it in a very safe place!
{% endhint %}

If you already have an account with it's mnemonic phrase Import your account with the command: (You will be prompted to input your mnemonic)

{% code overflow="wrap" %}
```sh
./layerd keys add $ACCOUNT_NAME --recover=true
```
{% endcode %}

{% hint style="info" %}
<mark style="color:blue;">You can check accounts any time with:</mark> \
`./layerd keys list`
{% endhint %}

8. **Export your addresses.** Your wallet account has two important addresses. First, get the "tellor" prefix address, which is used to send and receive tokens. Copy it and keep it in a safe place:

```bash
./layerd keys show $ACCOUNT_NAME
```

Next, add the `--bech val` flag to get the "tellorvaloper" prefix address, which is used for validator commands. Copy it and keep it in a safe place:

```bash
./layerd keys show $ACCOUNT_NAME --bech val
```

Add these addresses to your `.bashrc` or `.zshrc` file. Be sure to replace `your_tellor_prefix_address` and `your_tellorvaloper_prefix_address` in your command:

{% code overflow="wrap" %}
```bash
echo 'export TELLOR_ADDRESS=your_tellor_prefix_address' >> ~/.bashrc #.zshrc if mac
echo 'export TELLORVALOPER_ADDRESS=your_tellorvaloper_prefix_address' >> ~/.bashrc #.zshrc if mac
```
{% endcode %}

Restart your terminal, or use `source ~/.bashrc` before you continue. (if Linux) Restart your terminal, or use `source ~/.zshrc` before you continue. (if mac)

## Start your Layer Node!

{% hint style="success" %}
_<mark style="color:green;">**Before starting your node**</mark><mark style="color:green;">,</mark> it's a good idea to think about how you want to run it so that the process does not get killed accidentally._ [_GNU screen_](https://tellor.io/blog/how-to-manage-cli-applications-on-hosted-vms-with-screen/) _is a great option for beginners. More advanced setups can be achieved using systemd._
{% endhint %}

Run the command:

{% code overflow="wrap" %}
```sh
./layerd start --api.swagger --price-daemon-enabled=false --key-name $ACCOUNT_NAME
```
{% endcode %}

If your node is configured correctly, you should see the node connecting to end points before rapidly downloading blocks.   Please allow time for the node to sync before moving onto setting up a validator.\
