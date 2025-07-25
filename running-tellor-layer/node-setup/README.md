---
description: How to Operate Tellor Layer Node.
icon: rectangle-terminal
---

# Node Setup

## Recommended Hardware Specs

Operating a node <mark style="color:green;">for a personal RPC</mark> can be done using most modern computers.&#x20;

For running a <mark style="color:green;">**validator**</mark>**&#x20; more horsepower is recommend:**

* Modern cpu with at least 8 cores / threads
* ram: 32 gb
* storage: 500gb+ @ NVME gen3+
* network: 500mb/s DL, 100mb/s UL (the faster the better)

_Note: The memory requirement (32gb) is important to consider if you are planning to operate continuously as a validator. We have tested upgrades with oracle data store migrations that weren't possible on 16gb machines._

### Software Prerequisites

{% tabs %}
{% tab title="Linux" %}
jq, yq, sed, curl, wget, make, and **Go** are required for running the various commands and config scripts and commands in this guide:&#x20;

* **`jq` :** `sudo apt install jq`
* **`yq` :** `sudo apt install yq`
* **`sed` :** `sudo apt install sed`
* **`curl`**: `sudo apt install curl`
* **`wget`** : `sudo apt install wget`&#x20;
* `Go ≥ 1.22` : Use the default install instructions [here](https://go.dev/doc/install).
* `make` : `sudo apt install build-essential`
{% endtab %}

{% tab title="MacOS" %}
jq, yq, sed, and wget are required for running the various commands and config scripts in this guide:&#x20;

* **`jq`:** `brew install jq`
* **`yq`:** `brew install yq`
* **`sed`:** `brew install sed`
* **`wget`**`: brew install wget`&#x20;
* `Go ≥ 1.22` : Use the default install instructions [here](https://go.dev/doc/install).
* `make` : `xcode-select --install`&#x20;
{% endtab %}
{% endtabs %}

{% hint style="success" %}
* Commands shown should just work while logged in as a user (not root).&#x20;
* **I**f you are using an older Mac with an intel chip, the linux versions (amd64) in step 1 below may be used. (just remember to use the mac commands!)&#x20;
* If on raspberry pi or similar, use the binary downloads for "**arm64**".
{% endhint %}

## Choose How you will Sync your Node

There are two different ways to get a node running on **layertest-4**:

* **Snapshot sync**: Your node is configured with seeds and peers from which it will try to download recent chain state snapshots. This sync method is faster, but you will not be able to query block info (like transactions) for any blocks that were produced before the day of your sync.
* **Genesis sync**: Your node will start with the genesis binary and sync the entire chain. A different binary will be needed for each upgrade since genesis. This sync method can take a long time depending on how long layertest-4 has been live.

## 1. Download and Organize the `layerd` Binary(s)

{% hint style="warning" %}
**Be sure to select the tabs that work for your setup! You will get errors if you use the linux commands on mac and vice-versa.**&#x20;
{% endhint %}

{% tabs %}
{% tab title="Snapshot Sync" %}
First, download the binary from the [Tellor Github](https://github.com/tellor-io/layer/tags).

{% tabs %}
{% tab title="Linux" %}
<pre class="language-sh" data-overflow="wrap"><code class="lang-sh"># layertest-4 binary v5.1.0
<strong>mkdir -p ~/layer/binaries &#x26;&#x26; cd ~/layer/binaries &#x26;&#x26; mkdir v5.1.0 &#x26;&#x26; cd v5.1.0 &#x26;&#x26; wget https://github.com/tellor-io/layer/releases/download/v5.1.0/layer_Linux_x86_64.tar.gz &#x26;&#x26; tar -xvzf layer_Linux_x86_64.tar.gz
</strong></code></pre>
{% endtab %}

{% tab title="MacOS" %}
{% code overflow="wrap" %}
```sh
# layertest-4 binary v5.1.0
mkdir -p ~/layer/binaries && cd ~/layer/binaries && mkdir v5.1.0 && cd v5.1.0 && wget https://github.com/tellor-io/layer/releases/download/v5.1.0/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz
```
{% endcode %}
{% endtab %}
{% endtabs %}

Initialize .layer folder in your home directory:

```sh
./layerd init layer --chain-id layertest-4
```
{% endtab %}

{% tab title="Genesis sync" %}
Download the binaries from the [Tellor Github](https://github.com/tellor-io/layer/tags).

{% tabs %}
{% tab title="Linux" %}
{% code overflow="wrap" %}
```sh
# genesis binary v4.0.0
mkdir -p ~/layer/binaries && cd ~/layer/binaries && mkdir v4.0.0 && cd v4.0.0 && wget https://github.com/tellor-io/layer/releases/download/v4.0.0/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v4.0.2 (for upgrade name v4.0.1)
cd ~/layer/binaries && mkdir v4.0.1 && cd v4.0.1 && wget https://github.com/tellor-io/layer/releases/download/v4.0.2/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v4.0.3 (for upgrade name v4.0.3)
cd ~/layer/binaries && mkdir v4.0.3 && cd v4.0.3 && wget https://github.com/tellor-io/layer/releases/download/v4.0.3/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v5.0.0 (for upgrade name v5.0.0)
cd ~/layer/binaries && mkdir v5.0.0 && cd v5.0.0 && wget https://github.com/tellor-io/layer/releases/download/v5.0.0/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v5.1.0 (for upgrade name v5.1.0)
cd ~/layer/binaries && mkdir v5.1.0 && cd v5.1.0 && wget https://github.com/tellor-io/layer/releases/download/v5.1.0/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz
```
{% endcode %}
{% endtab %}

{% tab title="MacOS" %}
{% code overflow="wrap" %}
```sh
# genesis binary v3.0.1
mkdir -p ~/layer/binaries && cd ~/layer/binaries && mkdir v4.0.0 && cd v4.0.0 && wget https://github.com/tellor-io/layer/releases/download/v4.0.0/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz

# upgrade binary v4.0.2 (**for upgrade name v4.0.1**)
cd ~/layer/binaries && mkdir v4.0.1 && cd v4.0.1 && wget https://github.com/tellor-io/layer/releases/download/v4.0.2/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz

# upgrade binary v4.0.3
cd ~/layer/binaries && mkdir v4.0.3 && cd v4.0.3 && wget https://github.com/tellor-io/layer/releases/download/v4.0.3/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz

# upgrade binary v5.0.0 (**for upgrade name v5.0.0**)
cd ~/layer/binaries && mkdir v5.0.0 && cd v5.0.0 && wget https://github.com/tellor-io/layer/releases/download/v5.0.0/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz

# upgrade binary v5.1.0
cd ~/layer/binaries && mkdir v5.1.0 && cd v5.1.0 && wget https://github.com/tellor-io/layer/releases/download/v5.1.0/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz
```
{% endcode %}
{% endtab %}
{% endtabs %}

Initialize the chain config files:

```sh
# change directory to ~/layer/binaries/v4.0.0
cd ~/layer/binaries/v4.0.0

# initialize chain configs
./layerd init layer --chain-id layertest-4
```
{% endtab %}
{% endtabs %}

## 2. Edit Chain Configuration for Layer.

_These steps are the same if you are doing a snapshot sync or a genesis sync. Select the tab for your computer's architecture:_

{% tabs %}
{% tab title="Linux" %}
Download the latest setup script from the [layer repo](https://github.com/tellor-io/layer):

{% code overflow="wrap" %}
```sh
wget https://raw.githubusercontent.com/tellor-io/layer/refs/heads/main/layer_scripts/configure_layer_linux.sh
```
{% endcode %}

Give the script permission to execute, then run the script:

```sh
chmod +x configure_layer_linux.sh && ./configure_layer_linux.sh
```

**If you are doing a genesis sync for an archive node, be sure to set `pruning = "nothing"` in your app.toml file typically located at  `~/.layer/config/app.toml` .**
{% endtab %}

{% tab title="MacOS" %}
Download the latest setup script from the main layer repo.

{% code overflow="wrap" %}
```sh
wget https://raw.githubusercontent.com/tellor-io/layer/refs/heads/main/layer_scripts/configure_layer_mac.sh
```
{% endcode %}

Give the script permission to execute, then run the script:

```sh
chmod +x configure_layer_mac.sh && ./configure_layer_mac.sh
```

**If you are doing a genesis sync for an archive node, be sure to set `pruning = "nothing"` in your app.toml file typically located at  `~/.layer/config/app.toml` .**
{% endtab %}
{% endtabs %}

## 3. Make a Local Account

Create a tellor address (account) for starting the node with various options. This should be done even if you're not going to run a validator.

{% hint style="warning" %}
It's best practice to always handle mnemonics/keys with extreme care, even if it’s just for the testnet, and never use an address that holds real funds for testing.
{% endhint %}

If you do not yet have an account / mnemonic phrase, generate a new key pair with the command below. Choose an account name that's easy to remember. _**Save the output in a safe place if you'd like to be able to import the account later:**_

```sh
./layerd keys add YOUR_ACCOUNT_NAME
```

If you already have an account, you can Import it with the command:

{% code overflow="wrap" %}
```sh
./layerd keys add YOUR_ACCOUNT_NAME --recover
```
{% endcode %}

Export your "tellorvaloper" prefix address. Copy it and keep it handy for the next step:

```sh
./layerd keys show YOUR_ACCOUNT_NAME --bech val
```

## 4. Set System Variables

A Layer node uses the following variables:

* <mark style="color:green;">**TOKEN\_BRIDGE\_CONTRACT**</mark>: the token bridge contract address.
* <mark style="color:green;">**ETH\_RPC\_URL**</mark>: A reliable Sepolia RPC URL.
* <mark style="color:green;">**ETH\_RPC\_URL\_PRIMARY**</mark>: Sepolia RPC url for the reporter daemon (can be the same).
* <mark style="color:green;">**ETH\_RPC\_URL\_FALLBACK**</mark>: A second RPC url for calling the bridge contract if the primary RPC fails to respond.
* <mark style="color:green;">**WITHDRAW\_FREQUENCY**</mark>: For reporters, the daemon will automatically claim your tips (rewards) on this interval (in seconds)
* <mark style="color:green;">**REPORTERS\_VALIDATOR\_ADDRESS**</mark>: From step 3 above.

Set the environment variables so that they are set in new terminal windows by default. Open your .bashrc or .zshrc file with a text editor like nano:

{% tabs %}
{% tab title="Linux" %}
```
nano ~/.bashrc
```
{% endtab %}

{% tab title="MacOS" %}
```
nano ~/.zshrc
```
{% endtab %}
{% endtabs %}

Add these lines to the bottom of the file. Remember to replace the example `ETH_RPC_URL` with your actual Sepolia testnet RPC url, and if you're going to run a reporter, replace the `REPORTERS_VALIDATOR_ADDRESS` with your own as well.

```bash
export ETH_RPC_URL="wss://a.good.sepolia.rpc.url"
export ETH_RPC_URL_PRIMARY="wss://a.good.sepolia.rpc.url"
export ETH_RPC_URL_FALLBACK="https://another.sepolia.rpc.url"
export TOKEN_BRIDGE_CONTRACT="0x5acb5977f35b1A91C4fE0F4386eB669E046776F2"
export WITHDRAW_FREQUENCY="21600" # how often you want to withdraw rewards (seconds)
export REPORTERS_VALIDATOR_ADDRESS="tellorvaloper1YOUR_TELLORVALOPER_ADDRESS" # for recieving rewards
```

Load the new variables:

{% tabs %}
{% tab title="Linux" %}
```
source ~/.bashrc
```
{% endtab %}

{% tab title="MacOS" %}
```
source ~/.zshrc
```
{% endtab %}
{% endtabs %}

Exit nano with `ctrl^x` then enter `y` to save the changes.

### 5. Sync the Node

_<mark style="color:green;">**Before starting your node**</mark><mark style="color:green;">,</mark> it's a good idea to think about how you want to run it so that the process does not get killed accidentally. This is not obvious for beginners. Try_ [_GNU screen_](https://tellor.io/blog/how-to-manage-cli-applications-on-hosted-vms-with-screen/) _or tmux. More advanced setups can be achieved using systemd services._

Choose the tab depending on whether or not you are doing a genesis sync, or a state sync:

{% tabs %}
{% tab title="State Sync" %}
**We need to make a few more config edits to make sure your state sync goes smoothly.**&#x20;

1. To find a good **trusted height** to use for a snapshot sync, we need to find the height of a snapshot available from `https://node-palmito.tellorlayer.com/rpc/` . Copy and paste this entire block of commands into a terminal and hit enter:

```sh
NODE_URL="https://node-palmito.tellorlayer.com/rpc"
CURRENT_HEIGHT=$(./layerd status --node $NODE_URL | jq -r '.sync_info.latest_block_height')
NODE_ID=$(./layerd status --node $NODE_URL | jq -r '.node_info.id')
HOME_DIR=~/.layer
SNAPSHOT_INTERVAL=12500
SNAPSHOT_OFFSET=10000
remainder=$((CURRENT_HEIGHT % SNAPSHOT_INTERVAL))
if [ $remainder -ge $SNAPSHOT_OFFSET ]; then
    ESTIMATED_SNAPSHOT_HEIGHT=$((CURRENT_HEIGHT - (remainder - SNAPSHOT_OFFSET) - 12500))
else
    ESTIMATED_SNAPSHOT_HEIGHT=$((CURRENT_HEIGHT - (remainder + SNAPSHOT_INTERVAL - SNAPSHOT_OFFSET) - 12500))
fi
TRUSTED_HASH=$(curl -s "$NODE_URL/block?height=$ESTIMATED_SNAPSHOT_HEIGHT" | jq -r .result.block_id.hash)
echo "Trusted height: $ESTIMATED_SNAPSHOT_HEIGHT"
echo "Trusted hash: $TRUSTED_HASH"

```

The output should be something like:&#x20;

```sh
trusted height: 3785000
Trusted hash: DD27874AB1F5F4DFC5D7818E7CFBF8A8ECEDA745FFA78DF24D799B2B201418B9
```

2. Edit config.toml:

Open your config file:

```sh
nano ~/.layer/config/config.toml
```

Scroll or search (`ctrl^w`) the file and edit the state sync variables shown here to match the trusted height and trusted hash you found above:

```toml
# [statesync]
# ...
enable = true
#...
rpc_servers = "https://node-palmito.tellorlayer.com/rpc/,https://node-palmito.tellorlayer.com/rpc/"
trust_height = 3785000
trust_hash = "DD27874AB1F5F4DFC5D7818E7CFBF8A8ECEDA745FFA78DF24D799B2B201418B9"
trust_period = "168h0m0s"
```

Be sure to replace the `trust_height` and `trust_hash` with the block number and hash from the curl command above.

Exit nano with `ctrl^x` then enter `y` to save the changes.

3. Start your node:

{% code overflow="wrap" %}
```bash
./layerd start --home ~/.layer --keyring-backend test --key-name YOUR_ACCOUNT_NAME --api.enable --api.swagger
```
{% endcode %}

The node should start up quickly and begin downloading snapshots from peers.

{% hint style="info" %}
Some errors related to peer connections can be expected even if the snapshot sync is working properly. (e.g. "we need more peers", or "Failed to reconnect")
{% endhint %}
{% endtab %}

{% tab title="Genesis Sync" %}
#### Start your layer node with the command:

```bash
./layerd start --price-daemon-enabled=false --key-name YOUR_ACCOUNT_NAME
```

You should now see your log quickly downloading blocks!

#### Upgrades

Your node will stop syncing at the following block height(s) for each binary upgrade:

`452800 for upgrade v4.0.1` **(uses the v4.0.2 binary)**

`2154000 for upgrade v4.0.3`&#x20;

`3139971 for upgrade v5.0.0`

`5092670 for upgrade v5.1.0`

&#x20;When the sync stops for an upgrade at the heights shown above, you will need to kill the `layerd` process and start it back up again on the corresponding upgraded binary.\
\
&#xNAN;_**Notes on the  Upgrades:**_&#x20;

* _**The v4.0.2 binary is used at the height for the v4.0.1 upgrade. (This is not a typo)**_

{% code overflow="wrap" %}
```sh
# At height 452800 the node will stop syncing:
# change directory
cd ~/layer/binaries/v4.0.2

# resume syncing
./layerd start --home ~/.layer --keyring-backend test --key-name YOUR_ACCOUNT_NAME

# At height 2154000 the node will stop syncing:
# change directory
cd ~/layer/binaries/v4.0.3

# resume syncing
./layerd start --home ~/.layer --keyring-backend test --key-name YOUR_ACCOUNT_NAME

# At height 3139971 the node will stop syncing:
# change directory
cd ~/layer/binaries/v5.0.0

# resume syncing
./layerd start --home ~/.layer --keyring-backend test --key-name YOUR_ACCOUNT_NAME

# At height 5092670 the node will stop syncing:
# change directory
cd ~/layer/binaries/v5.1.0

# resume syncing
./layerd start --home ~/.layer --keyring-backend test --key-name YOUR_ACCOUNT_NAME
```
{% endcode %}
{% endtab %}
{% endtabs %}

To check if the node is fully synced, open a separate terminal window and run:

```sh
./layerd status
```

You should see a JSON formatted list of information about your running node. If you see `catching_up":false` that means that you're node is fully synced and ready to use!
