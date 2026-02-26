---
description: How to Operate Tellor Layer Node.
icon: rectangle-terminal
---

# Node Setup Manual (testnet)

## Recommended Hardware Specs

Operating a node for a personal RPC can be done using most modern computers.&#x20;

For running a validator, _more power_ is recommen&#x64;**:**

* Modern cpu with at least 8 cores / threads
* ram: 32 gb
* storage: 1000gb+ @ NVME gen3+
* network: 500mb/s DL, 100mb/s UL (the faster the better)

_Note: The memory requirement (32gb) is important to consider if you are planning to operate continuously as a validator. We have tested upgrades with oracle data store migrations that weren't possible on 16gb machines._

### _<mark style="color:green;">Check the</mark>_ [_<mark style="color:green;">Quick Start</mark>_](../../running-tellor/node-setup-quick-start.md) _<mark style="color:green;">section for installers:</mark>_

{% content-ref url="../quick-start-new-faster.md" %}
[quick-start-new-faster.md](../quick-start-new-faster.md)
{% endcontent-ref %}

### Software Prerequisites

{% tabs %}
{% tab title="Linux" %}
jq, yq, sed, curl, wget, make, and **Go** are required for running the various commands and config scripts and commands in this guide:&#x20;

* **`jq` :** `sudo apt install jq`
* **`yq` :** `sudo apt install yq`
* **`sed` :** `sudo apt install sed`
* **`curl`**: `sudo apt install curl`
* **`wget`** : `sudo apt install wget`&#x20;
* `Go version 1.22` : Use the default install instructions [here](https://go.dev/doc/install).
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

There are two three ways to get a node running on **layertest-4**:

* **State Sync**: Your node is configured with seeds and peers from which it will try to download recent chain state snapshots. This sync method is faster, but you will not be able to query block info (like transactions) for any blocks that were produced before the day of your sync.
* **Genesis sync**: Your node will start with the genesis binary and sync the entire chain. A different binary will be needed for each upgrade since genesis. This sync method can take a long time depending on how long layertest-4 has been live.

## 1. Download and Organize the `layerd` Binary(s)

{% hint style="warning" %}
**Be sure to select the tabs that work for your setup! You will get errors if you use the linux commands on mac and vice-versa.**&#x20;
{% endhint %}

{% tabs %}
{% tab title="State Sync" %}
First, download the binary from the [Tellor Github](https://github.com/tellor-io/layer/tags).

{% tabs %}
{% tab title="Linux" %}
<pre class="language-sh" data-overflow="wrap"><code class="lang-sh"><strong>mkdir -p ~/layer/binaries &#x26;&#x26; cd ~/layer/binaries &#x26;&#x26; mkdir v6.1.3 &#x26;&#x26; cd v6.1.3 &#x26;&#x26; wget https://github.com/tellor-io/layer/releases/download/v6.1.3/layer_Linux_x86_64.tar.gz &#x26;&#x26; tar -xvzf layer_Linux_x86_64.tar.gz
</strong></code></pre>
{% endtab %}

{% tab title="MacOS" %}
<pre class="language-sh" data-overflow="wrap"><code class="lang-sh"><strong>mkdir -p ~/layer/binaries &#x26;&#x26; cd ~/layer/binaries &#x26;&#x26; mkdir v6.1.3 &#x26;&#x26; cd v6.1.3 &#x26;&#x26; wget https://github.com/tellor-io/layer/releases/download/v6.1.3/layer_Darwin_arm64.tar.gz &#x26;&#x26; tar -xvzf layer_Darwin_arm64.tar.gz
</strong></code></pre>
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

# upgrade binary v4.0.2
cd ~/layer/binaries && mkdir v4.0.1 && cd v4.0.1 && wget https://github.com/tellor-io/layer/releases/download/v4.0.2/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v4.0.3
cd ~/layer/binaries && mkdir v4.0.3 && cd v4.0.3 && wget https://github.com/tellor-io/layer/releases/download/v4.0.3/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v5.0.0
cd ~/layer/binaries && mkdir v5.0.0 && cd v5.0.0 && wget https://github.com/tellor-io/layer/releases/download/v5.0.0/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v5.1.0
cd ~/layer/binaries && mkdir v5.1.0 && cd v5.1.0 && wget https://github.com/tellor-io/layer/releases/download/v5.1.0/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v5.1.1
cd ~/layer/binaries && mkdir v5.1.1 && cd v5.1.1 && wget https://github.com/tellor-io/layer/releases/download/v5.1.1/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v5.1.2
cd ~/layer/binaries && mkdir v5.1.2 && cd v5.1.2 && wget https://github.com/tellor-io/layer/releases/download/v5.1.2/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v6.0.0
cd ~/layer/binaries && mkdir v6.0.0 && cd v6.0.0 && wget https://github.com/tellor-io/layer/releases/download/v6.0.0/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v6.1.0
cd ~/layer/binaries && mkdir v6.1.0 && cd v6.1.0 && wget https://github.com/tellor-io/layer/releases/download/v6.1.0/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v6.1.1-fix (for upgrade name v6.1.1)
cd ~/layer/binaries && mkdir v6.1.1 && cd v6.1.1 && wget https://github.com/tellor-io/layer/releases/download/v6.1.1/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v6.1.2
cd ~/layer/binaries && mkdir v6.1.2 && cd v6.1.2 && wget https://github.com/tellor-io/layer/releases/download/v6.1.2/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v6.1.3
cd ~/layer/binaries && mkdir v6.1.3 && cd v6.1.3 && wget https://github.com/tellor-io/layer/releases/download/v6.1.3/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz
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

# upgrade binary v5.1.1
cd ~/layer/binaries && mkdir v5.1.1 && cd v5.1.1 && wget https://github.com/tellor-io/layer/releases/download/v5.1.1/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz

# upgrade binary v5.1.2
cd ~/layer/binaries && mkdir v5.1.2 && cd v5.1.2 && wget https://github.com/tellor-io/layer/releases/download/v5.1.2/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz
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

## 2. Set System Variables

A Layer node uses the following variables:

* <mark style="color:green;">**TOKEN\_BRIDGE\_CONTRACT**</mark>: the token bridge contract address.
* <mark style="color:green;">**ETH\_RPC\_URL**</mark>: A reliable Sepolia RPC URL.
* <mark style="color:green;">**ETH\_RPC\_URL\_PRIMARY**</mark>: Sepolia RPC url for the reporter daemon (can be the same).
* <mark style="color:green;">**ETH\_RPC\_URL\_FALLBACK**</mark>: A second RPC url for calling the bridge contract if the primary RPC fails to respond.

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
export TOKEN_BRIDGE_CONTRACT="0x62733e63499a25E35844c91275d4c3bdb159D29d"
```

Exit nano with `ctrl^x` then enter `y` to save the changes.

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

## 3. Edit Chain Configuration for Tellor.

We need to open up the tellor layer config files and change some variables. You can use any local text editor like code, vim, or nano.&#x20;

_**Note: All variables not shown can be safely left as is.**_

In `~/.layer/config/app.toml`:

```sh
# The minimum gas prices a validator is willing to accept for processing a
# transaction. A transaction's fees must meet the minimum of any denomination
# specified in this config (e.g. 0.25token1,0.0001token2).
minimum-gas-prices = "0loya"
# ...
# Address defines the API server to listen on.
address = "tcp://0.0.0.0:1317"
#...
```

In `~/.layer/config/client.toml`:

```sh
#...
# The network chain ID
chain-id = "layertest-4"
# The keyring's backend, where the keys are stored (os|file|kwallet|pass|test|memory)
keyring-backend = "test"
#...
```

In `~/.layer/config/config.toml`:

```sh
#...
# TCP or UNIX socket address for the RPC server to listen on (optional)
laddr = "tcp://0.0.0.0:26657"
#...
# Use '["*"]' to allow any origin
cors_allowed_origins = ["*"]
#...
# Comma separated list of nodes to keep persistent connections to
persistent_peers = "ac7c10dc3de67c4394271c564671eeed4ac6f0e0@34.229.148.107:26656,8d19cdf430e491d6d6106863c4c466b75a17088a@54.153.125.203:26656,c7b175a5bafb35176cdcba3027e764a0dbd0811c@34.219.95.82:26656,05105e8bb28e8c5ace1cecacefb8d4efb0338ec6@18.218.114.74:26656,705f6154c6c6aeb0ba36c8b53639a5daa1b186f6@3.80.39.230:26656,1f6522a346209ee99ecb4d3e897d9d97633ae146@3.101.138.30:26656,3822fa2eb0052b36360a7a6e285c18cc92e26215@175.41.188.192:26656"
#...
# How long we wait after committing a block, before starting on the new
# height (this gives us a chance to receive some more precommits, even
# though we already have +2/3).
timeout_commit = "1s"
#...
```

### 4. Sync the Node

_<mark style="color:green;">**Before starting your node**</mark><mark style="color:green;">,</mark> it's a good idea to think about how you want to run it so that the process does not get killed accidentally. This is not obvious for beginners. Try_ [_GNU screen_](https://tellor.io/blog/how-to-manage-cli-applications-on-hosted-vms-with-screen/) _or tmux. More advanced setups can be achieved using systemd services._

Choose the tab depending on whether or not you are doing a genesis sync, or a state sync:

{% tabs %}
{% tab title="State Sync" %}
**We need to make a few more config edits to make sure your state sync goes smoothly.**&#x20;

1. To find a good **trusted height** to use for a snapshot sync, we need to find the height of a snapshot available from `https://node-palmito.tellorlayer.com/rpc/` . Copy and paste this entire block of commands into a terminal and hit enter:

<pre class="language-sh"><code class="lang-sh"><strong>export LATEST_HEIGHT=$(curl -s https://node-palmito.tellorlayer.com/rpc/block | jq -r .result.block.header.height); \
</strong>export TRUSTED_HEIGHT=$((LATEST_HEIGHT - 35000)); \
export TRUSTED_HASH=$(curl -s "https://node-palmito.tellorlayer.com/rpc/block?height=$TRUSTED_HEIGHT" | jq -r .result.block_id.hash); \
echo $TRUSTED_HEIGHT $TRUSTED_HASH

</code></pre>

The output should be something like:&#x20;

```sh
trusted_height: 3785000
Trusted_hash: DD27874AB1F5F4DFC5D7818E7CFBF8A8ECEDA745FFA78DF24D799B2B201418B9
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
./layerd start --home ~/.layer --key-name ACCOUNT_NAME --keyring-backend test --api.enable --api.swagger
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

`7375500 for upgrade v5.1.1`

`9569214 for upgrade v5.1.2`

`11012370 for upgrade v6.0.0`&#x20;

`14800000 for upgrade v6.1.0`

`15176288 for upgrade v6.1.1`

`16864110 for upgrade v6.1.2`

&#x20;When the sync stops for an upgrade at the heights shown above, you will need to kill the `layerd` process and start it back up again on the corresponding upgraded binary.\
\
&#xNAN;_**Notes on the  Upgrades:**_&#x20;

* _**The v4.0.2 binary is used at the height for the v4.0.1 upgrade. (This is not a typo)**_

{% code overflow="wrap" %}
```sh
# At height 452800 the node will stop syncing:
# change directory
cd ~/layer/binaries/v4.0.2

# TO RESUME SYNCING:
./layerd start --home ~/.layer --key-name ACCOUNT_NAME --keyring-backend test --api.enable --api.swagger

# At height 2154000 the node will stop syncing:
# change directory
cd ~/layer/binaries/v4.0.3
# resume syncing...

# At height 3139971 the node will stop syncing:
# change directory
cd ~/layer/binaries/v5.0.0
# resume syncing...

# At height 5092670 the node will stop syncing:
# change directory
cd ~/layer/binaries/v5.1.0
# resume syncing...

# At height 7375500 the node will stop syncing:
# change directory
cd ~/layer/binaries/v5.1.1
# resume syncing...

# At height 9569214 the node will stop syncing:
# change directory
cd ~/layer/binaries/v5.1.2
# resume syncing...

# At height 11012370 the node will stop syncing:
# change directory
cd ~/layer/binaries/v6.0.0
# resume syncing...

# At height 14800000 the node will stop syncing:
# change directory
cd ~/layer/binaries/v6.1.0

# At height 15176288 the node will stop syncing:
# change directory
cd ~/layer/binaries/v6.1.1

# At height 16864110 the node will stop syncing:
# change directory
cd ~/layer/binaries/v6.1.2
```
{% endcode %}
{% endtab %}
{% endtabs %}

To check if the node is fully synced, open a separate terminal window and run:

```sh
./layerd status
```

You should see a JSON formatted list of information about your running node. If you see `catching_up":false` that means that you're node is fully synced and ready to use!
