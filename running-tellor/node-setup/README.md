---
description: How to Operate Tellor Node.
icon: rectangle-terminal
---

# Node Setup Manual

## Recommended Hardware Specs

Operating a node for a personal RPC can be done usin most modern computers. Even modest hardware should be fine for this purpose.

Operating a **validator:**

* Modern cpu with at least 8 cores / threads
* ram: 32 gb + 16gb swap space
* storage: 1000gb+ @ NVME gen3+
* network: 500mb/s DL, 100mb/s UL (the faster the better)

_Note: The memory requirement (32gb) is a minimum that is important to consider if you are planning to operate continuously as a validator. We have tested upgrades with oracle data store migrations that weren't possible on 16gb machines even with swap space._

### _<mark style="color:green;">Check the</mark>_ [_<mark style="color:green;">Quick Start</mark>_](../node-setup-quick-start.md) _<mark style="color:green;">section for installers:</mark>_

{% content-ref url="../node-setup-quick-start.md" %}
[node-setup-quick-start.md](../node-setup-quick-start.md)
{% endcontent-ref %}

### Software Prerequisites

{% tabs %}
{% tab title="Linux" %}
jq, yq, sed, curl, wget, make, and **Go** are required for running the various commands and config scripts and commands in this guide:&#x20;

* **`jq` :** `sudo apt install jq`
* **`sed` :** `sudo apt install sed`
* **`curl`**: `sudo apt install curl`
* **`wget`** : `sudo apt install wget`&#x20;
* `Go version  1.22` : Use the default install instructions [here](https://go.dev/doc/install).
* `make` : `sudo apt install build-essential`
{% endtab %}

{% tab title="MacOS" %}
jq, yq, sed, curl, wget, make, and **Go** are required for running the various commands and config scripts and commands in this guide:&#x20;

* **`jq`:** `brew install jq`
* **`sed`:** `brew install sed`
* **`wget`**`: brew install wget`&#x20;
* `Go ≥ 1.22` : Use the default install instructions [here](https://go.dev/doc/install).
* `make` : `xcode-select --install`&#x20;
{% endtab %}
{% endtabs %}

{% hint style="success" %}
* Commands shown should just work while logged in as a user (using root is not recommended).&#x20;
* **I**f you are using an older Mac with an intel chip, the linux versions (amd64) in step 1 below may be used. (just remember to use the mac commands!)&#x20;
* If on raspberry pi or similar, use the binary downloads for "**arm64**".
{% endhint %}

## Choose How you will Sync your Node

There are two options for starting a new tellor-1 node:

* **State sync**: Your node is configured with seeds and peers from which it will try to download recent chain state snapshots. This sync method is faster, but you will not be able to query block info (like transactions) for any blocks that were produced before the day of your sync. For a new setup state sync, the setup script works great!
* **Genesis sync**: Your node will start with the genesis binary and sync the entire chain. A different binary will be needed for each upgrade since genesis. This sync method can take a long time depending on how long tellor-1 has been live.

## 1. Download and Organize the `layerd` Binary(s)

{% hint style="info" %}
**As you progress through the steps, be sure to select the tabs that work for your setup! You will get errors if you use the linux commands on mac and vice-versa.**&#x20;
{% endhint %}

{% tabs %}
{% tab title="State Sync" %}
First, download the binary from the [Tellor Github](https://github.com/tellor-io/layer/tags).

{% tabs %}
{% tab title="Linux" %}
<pre class="language-sh" data-overflow="wrap"><code class="lang-sh"><strong>mkdir -p ~/layer/binaries &#x26;&#x26; cd ~/layer/binaries &#x26;&#x26; mkdir v6.0.0 &#x26;&#x26; cd v6.0.0 &#x26;&#x26; wget https://github.com/tellor-io/layer/releases/download/v6.0.0/layer_Linux_x86_64.tar.gz &#x26;&#x26; tar -xvzf layer_Linux_x86_64.tar.gz
</strong></code></pre>
{% endtab %}

{% tab title="MacOS" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries && cd ~/layer/binaries && mkdir v6.0.0 && cd v6.0.0 && wget https://github.com/tellor-io/layer/releases/download/v6.0.0/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz
```
{% endcode %}
{% endtab %}
{% endtabs %}

Initialize .layer folder in your home directory:

```sh
./layerd init layer --chain-id tellor-1
```
{% endtab %}

{% tab title="Genesis sync" %}
Download the binaries from the [Tellor Github](https://github.com/tellor-io/layer/tags).

{% tabs %}
{% tab title="Linux" %}
{% code overflow="wrap" %}
```sh
# genesis binary v4.0.3
mkdir -p ~/layer/binaries && cd ~/layer/binaries && mkdir v4.0.3 && cd v4.0.3 && wget https://github.com/tellor-io/layer/releases/download/v4.0.3/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v5.0.0
cd ~/layer/binaries && mkdir v5.0.0 && cd v5.0.0 && wget https://github.com/tellor-io/layer/releases/download/v5.0.0/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v5.1.0
cd ~/layer/binaries && mkdir v5.1.0 && cd v5.1.0 && wget https://github.com/tellor-io/layer/releases/download/v5.1.0/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v5.1.1
cd ~/layer/binaries && mkdir v5.1.1 && cd v5.1.1 && wget https://github.com/tellor-io/layer/releases/download/v5.1.1/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v5.1.2
cd ~/layer/binaries && mkdir v5.1.2 && cd v5.1.2 && wget https://github.com/tellor-io/layer/releases/download/v5.1.2/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz
```
{% endcode %}
{% endtab %}

{% tab title="MacOS" %}
{% code overflow="wrap" %}
```sh
# genesis binary v4.0.3
mkdir -p ~/layer/binaries && cd ~/layer/binaries && mkdir v4.0.3 && cd v4.0.3 && wget https://github.com/tellor-io/layer/releases/download/v4.0.3/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz

# upgrade binary v5.0.0
cd ~/layer/binaries && mkdir v5.0.0 && cd v5.0.0 && wget https://github.com/tellor-io/layer/releases/download/v5.0.0/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz

# upgrade binary v5.1.0
cd ~/layer/binaries && mkdir v5.1.0 && cd v5.1.0 && wget https://github.com/tellor-io/layer/releases/download/v5.1.0/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz

# upgrade binary v5.1.1
cd ~/layer/binaries && mkdir v5.1.1 && cd v5.1.1 && wget https://github.com/tellor-io/layer/releases/download/v5.1.1/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz
```
{% endcode %}
{% endtab %}
{% endtabs %}

Initialize the chain config files:

```sh
# change directory to ~/layer/binaries/v4.0.0
cd ~/layer/binaries/v4.0.3

# initialize chain configs
./layerd init layer --chain-id tellor-1
```
{% endtab %}
{% endtabs %}

## 2. Set System Variables

A Layer node uses the following variables:

* <mark style="color:green;">**TOKEN\_BRIDGE\_CONTRACT**</mark>: the token bridge contract address.
* <mark style="color:green;">**ETH\_RPC\_URL**</mark>: A reliable Ethereum RPC URL.
* <mark style="color:green;">**ETH\_RPC\_URL\_PRIMARY**</mark>: Ethereum RPC url for the reporter daemon (can be the same).
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

Add these lines to the bottom of the file. Remember to replace the example `ETH_RPC_URL` with your actual Ethereum RPC url, and if you're going to run a reporter, replace the `REPORTERS_VALIDATOR_ADDRESS` with your own as well.

```bash
export ETH_RPC_URL="wss://a.good.ethereum.rpc.url"
export ETH_RPC_URL_PRIMARY="wss://a.good.ethereum.rpc.url"
export ETH_RPC_URL_FALLBACK="https://another.ethereum.rpc.url"
export TOKEN_BRIDGE_CONTRACT="0x5589e306b1920F009979a50B88caE32aecD471E4"
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

We need to open up the tellor layer config files and change some variables. You can use any local text editor like code, vim, or nano.

_**Note: All other variables can be safely left as is.**_

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
chain-id = "tellor-1"
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
persistent_peers = "5a9db46eceb055c9238833aa54e15a2a32a09c9a@54.67.36.145:26656,f2644778a8a2ca3b55ec65f1b7799d32d4a7098e@54.149.160.93:26656,2904aa32501548e127d3198c8f5181fb4d67bbe6@18.116.23.104:26656,7fd4d34f3b19c41218027d3b91c90d073ab2ba66@54.221.149.61:26656,2b8af463a1f0e84aec6e4dbf3126edf3225df85e@13.52.231.70:26656,9358c72aa8be31ce151ef591e6ecf08d25812993@18.143.181.83:26656,cbb94e01df344fdfdee1fdf2f9bb481712e7ef8d@34.228.44.252:26656"
#...
# How long we wait after committing a block, before starting on the new
# height (this gives us a chance to receive some more precommits, even
# though we already have +2/3).
timeout_commit = "1s"
#...
```

### 4. Sync the Node

_<mark style="color:green;">**Before starting your node**</mark><mark style="color:green;">,</mark> it's a good idea to think about how you want to run it so that the process does not get killed accidentally. This is not obvious for beginners. Try_ [_GNU screen_](https://tellor.io/blog/how-to-manage-cli-applications-on-hosted-vms-with-screen/) _or tmux. More advanced setups can be achieved using_[ _systemd services_](example-.service-files.md)_._

Choose the tab depending on whether or not you are doing a genesis sync, or a state sync:

{% tabs %}
{% tab title="State Sync" %}
**We need to make a few more config edits to make sure your state sync goes smoothly.**&#x20;

1. To find a good **trusted height** to use for a snapshot sync, we need to find the height of a snapshot available from `https://mainnet.tellorlayer.com/rpc/` . Copy and paste this entire block of commands into a terminal and hit enter:

```sh
export LATEST_HEIGHT=$(curl -s https://mainnet.tellorlayer.com/rpc/block | jq -r .result.block.header.height); \
export TRUSTED_HEIGHT=$((LATEST_HEIGHT - 35000)); \
export TRUSTED_HASH=$(curl -s "https://mainnet.tellorlayer.com/rpc/block?height=$TRUSTED_HEIGHT" | jq -r .result.block_id.hash); \
echo $TRUSTED_HEIGHT $TRUSTED_HASH

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
rpc_servers = "https://mainnet.tellorlayer.com/rpc/,https://mainnet.tellorlayer.com/rpc/"
trust_height = 3785000
trust_hash = "DD27874AB1F5F4DFC5D7818E7CFBF8A8ECEDA745FFA78DF24D799B2B201418B9"
trust_period = "168h0m0s"
```

Be sure to replace the `trust_height` and `trust_hash` with the block number and hash from the curl command above.

Exit nano with `ctrl^x` then enter `y` to save the changes.

3. Start your node:

{% code overflow="wrap" %}
```bash
./layerd start --home ~/.layer --keyring-backend test --api.enable --api.swagger
```
{% endcode %}

The node should start up quickly and begin downloading a state snapshot from peers.

{% hint style="info" %}
Some errors related to peer connections can be expected even if the snapshot sync is working properly. (e.g. "we need more peers", or "Failed to reconnect")
{% endhint %}
{% endtab %}

{% tab title="Genesis Sync" %}
#### Start your layer node with the command:

```bash
./layerd start --key-name YOUR_ACCOUNT_NAME
```

You should now see your log quickly downloading blocks!

#### Upgrades

Your node will stop syncing at the following block height(s) for each binary upgrade:

`1534900 for upgrade v5.0.0`&#x20;

`3891401 for upgrade v5.1.0`&#x20;

`6699035 for upgrade v5.1.1`

`8593590 for upgrade v5.1.2`

`9908000 for upgrade v6.0.0`

&#x20;When the sync stops for an upgrade at the heights shown above, you will need to kill the `layerd` process and start it back up again on the corresponding upgraded binary.

{% code overflow="wrap" %}
```sh
# At height 1534900 the node will stop syncing:
# change directory
cd ~/layer/binaries/v5.0.0

# resume syncing
./layerd start --home ~/.layer --keyring-backend test --api.enable --api.swagger

# At height 3891401 the node will stop syncing:
# change directory
cd ~/layer/binaries/v5.1.0

# resume syncing
./layerd start --home ~/.layer --keyring-backend test --api.enable --api.swagger

# At height 6699035 the node will stop syncing:
# change directory
cd ~/layer/binaries/v5.1.1

# resume syncing
./layerd start --home ~/.layer --keyring-backend test --api.enable --api.swagger

# At height 8593590 the node will stop syncing:
# change directory
cd ~/layer/binaries/v5.1.2

# At height 9908000 the node will stop syncing:
# change directory
cd ~/layer/binaries/v6.0.0

# resume syncing
./layerd start --home ~/.layer --keyring-backend test --api.enable --api.swagger
```
{% endcode %}
{% endtab %}
{% endtabs %}

To check if the node is fully synced, open a separate terminal window and run:

```sh
./layerd status
```

You should see a JSON formatted list of information about your running node. If you see `catching_up":false` that means that you're node is fully synced and ready to use!
