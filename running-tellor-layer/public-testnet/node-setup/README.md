---
description: How to set up a Tellor Layer Node.
---

# Node Setup

### Recommended Machine Specs

Running a node for development or as a personal RPC can be done using most modern computers with at least 16gb ram.

**If operating a validator / reporter we recommend:**

* Modern cpu with at least 8 cores / threads
* ram: 32 gb
* storage: 500gb+ @ nvme gen3
* network: 500mb/s DL, 100mb/s UL (the faster the better)&#x20;

### Pre-requisites

{% hint style="info" %}
Commands shown should be used while logged in as a user (not root).
{% endhint %}

{% tabs %}
{% tab title="Linux" %}
Golang is required for running layer. jq, yq, and sed are required for running the various config scripts:&#x20;

* **jq :** `sudo apt install jq`
* **yq :** `sudo apt install yq`
* **sed :** `sudo apt install sed`
* **`curl`**`: sudo apt install curl`
* **`wget`**`: sudo apt install wget`

If you would like to build the binaries from source, you will need **Golang** ≥ 1.22. Use the default install instructions [here](https://go.dev/doc/install).
{% endtab %}

{% tab title="MacOS" %}
Golang is required for running layer. jq, yq, and sed are required for running the various config scripts:&#x20;

* **jq:** `brew install jq`
* **yq:** `brew install yq`
* **sed:** `brew install sed`
* **`wget`**`: brew install wget`

If you would like to build the binaries from source, you will need **Golang** ≥ 1.22. Use the default install instructions [here](https://go.dev/doc/install).
{% endtab %}
{% endtabs %}

### Choose How you will Sync your Node

There are Two different ways to get a node running on **layertest-3**. You can sync from a snapshot, or from genesis. Syncing from peer snapshot works best for most people. You should sync from genesis if you want to have the full chain history for analysis.

* Snapshot sync: Your node is configured with seeds and peers from which it will try to download recent chain state snapshots. This sync method should take no more than one hour to complete, but you will not be able to query chain history before the day you synced.
* Genesis sync: Your node will start with the genesis binary and sync the entire chain. A different binary will be needed for each upgrade since genesis. This sync method can take a long time depending on how long layertest-3 has been live.

### 1. Download and Organize the `layerd` Binary(s)

{% hint style="info" %}
**Be sure to select the tabs that work for your setup.**
{% endhint %}

{% tabs %}
{% tab title="Snapshot Sync" %}
First, download the binary from the [Tellor Github](https://github.com/tellor-io/layer/tags).

{% tabs %}
{% tab title="Linux" %}
<pre class="language-sh" data-overflow="wrap"><code class="lang-sh"># current layertest-3 binary v3.0.4
<strong>mkdir -p ~/layer/binaries &#x26;&#x26; cd ~/layer/binaries &#x26;&#x26; mkdir v3.0.4 &#x26;&#x26; cd v3.0.4 &#x26;&#x26; wget https://github.com/tellor-io/layer/releases/download/v3.0.4/layer_Linux_x86_64.tar.gz &#x26;&#x26; tar -xvzf layer_Linux_x86_64.tar.gz
</strong></code></pre>
{% endtab %}

{% tab title="MacOS" %}
<pre class="language-sh" data-overflow="wrap"><code class="lang-sh"># current layertest-3 binary v3.0.4
<strong>mkdir -p ~/layer/binaries &#x26;&#x26; cd ~/layer/binaries &#x26;&#x26; mkdir v3.0.4 &#x26;&#x26; cd v3.0.4 &#x26;&#x26; wget https://github.com/tellor-io/layer/releases/download/v3.0.4/layer_Darwin_arm64.tar.gz &#x26;&#x26; tar -xvzf layer_Darwin_arm64.tar.gz
</strong></code></pre>
{% endtab %}
{% endtabs %}

Initialize .layer folder in your home directory:

```sh
./layerd init layer --chain-id layertest-3
```

_Note: don't forget to rename or remove any old installations (`rm -rf ~/.layer`)_
{% endtab %}

{% tab title="Genesis sync" %}
Download the binaries from the [Tellor Github](https://github.com/tellor-io/layer/tags).

{% tabs %}
{% tab title="Linux" %}
{% code overflow="wrap" %}
```sh
# genesis binary v3.0.1
mkdir -p ~/layer/binaries && cd ~/layer/binaries && mkdir v3.0.1 && cd v3.0.1 && wget https://github.com/tellor-io/layer/releases/download/v3.0.1/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v3.0.3 (**for upgrade v3.0.2**)
cd ~/layer/binaries && mkdir v3.0.2 && cd v3.0.2 && wget https://github.com/tellor-io/layer/releases/download/v3.0.3/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# upgrade binary v3.0.4
cd ~/layer/binaries && mkdir v3.0.4 && cd v3.0.4 && wget https://github.com/tellor-io/layer/releases/download/v3.0.4/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz
```
{% endcode %}
{% endtab %}

{% tab title="MacOS" %}
{% code overflow="wrap" %}
```sh
# genesis binary v3.0.1
mkdir -p ~/layer/binaries && cd ~/layer/binaries && mkdir v3.0.1 && cd v3.0.1 && wget https://github.com/tellor-io/layer/releases/download/v3.0.1/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz

# upgrade binary v3.0.3 (**for upgrade v3.0.2**)
cd ~/layer/binaries && mkdir v3.0.2 && cd v3.0.2 && wget https://github.com/tellor-io/layer/releases/download/v3.0.3/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz

# upgrade binary v3.0.4
cd ~/layer/binaries && mkdir v3.0.4 && cd v3.0.4 && wget https://github.com/tellor-io/layer/releases/download/v3.0.4/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz
```
{% endcode %}
{% endtab %}
{% endtabs %}

Initialize the chain config files:

```sh
# change directory to ~/layer/binaries/v3.0.1
cd ~/layer/binaries/v3.0.1

# initialize chain configs
./layerd init layer --chain-id layertest-3
```

_Note: don't forget to rename or remove any old installations (`rm -rf ~/.layer`)_
{% endtab %}
{% endtabs %}

### 2. Edit Chain Configuration for Layer.

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
{% endtab %}
{% endtabs %}

### 3. Make a Local Account

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

### 4. Set System Variables

A Layer node uses the following variables:

* TOKEN\_BRIDGE\_CONTRACT: the token bridge contract address.
* ETH\_RPC\_URL: A reliable sepolia RPC url for calling the bridge contract.

{% hint style="info" %}
If you are starting layer with a bash script, be sure to include export statements for these variables at the top of your start script. If running layerd as a system service, they can be added to your .service file. Commands shown are for running layer in a regular bash terminal or with tmux or screen.
{% endhint %}

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

Add these lines to the bottom of the file. Remember to replace the example URL with your Sepolia testnet RPC url:

```bash
export ETH_RPC_URL="wss://a.good.sepolia.rpc.url"
export TOKEN_BRIDGE_CONTRACT="0x6ac02f3887b358591b8b2d22cfb1f36fa5843867"
```

To load the variables into any open shell (terminal window):

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

_<mark style="color:green;">**Before starting your node**</mark><mark style="color:green;">,</mark> it's a good idea to think about how you want to run it so that the process does not get killed accidentally. This is not obvious for beginners._ [_GNU screen_](https://tellor.io/blog/how-to-manage-cli-applications-on-hosted-vms-with-screen/) _is a great option for beginners. More advanced setups can be achieved using systemd._

Choose the tab depending on whether or not you are doing a genesis sync, or a state sync:

{% tabs %}
{% tab title="State Sync" %}
**We need to make a few more config edits to make sure your state sync goes smoothly.**&#x20;

1. Use curl to find a good `TRUSTED_HEIGHT` to use for downloading snapshots:

```sh
export LATEST_HEIGHT=$(curl -s tellorlayer.com:26657/block | jq -r .result.block.header.height); \
export TRUSTED_HEIGHT=$((LATEST_HEIGHT-8000)); \ 
export TRUSTED_HASH=$(curl -s "tellorlayer.com:26657/block?height=$TRUSTED_HEIGHT" | jq -r .result.block_id.hash); \
echo $TRUSTED_HEIGHT $TRUSTED_HASH
```

The command should output something like: `147139 0BCE40CD31D205453DA001780CBF765F3C64FCCB9DCB2F9825872D042780A288.`

2. Edit config.toml:

Open your config file:

```sh
nano ~/.layer/config/config.toml
```

Scroll or search (ctrl^w) the file and edit the state sync variables shown here:

```toml
# [statesync]
enable = true

#...
rpc_servers = "https://tellor.blkjy.io/,https://tellor.blkjy.io/"
trust_height = 147139
trust_hash = "F23E2ACAFF92FFEDE14CC9949A60F50E7C6D5A2D40BC9C838DF523944063294D"
trust_period = "168h0m0s"
```

Be sure to replace the `trust_height` and `trust_hash` with the block number and hash from the curl command above.

Exit nano with `ctrl^x` then enter `y` to save the changes.

3. Start your node:

```bash
./layerd start --price-daemon-enabled=false --home ~/.layer --key-name YOUR_ACCOUNT_NAME
```

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

Your node will stop syncing at block height for each binary upgrade:

`156999 for upgrade v3.0.2`

`1185570 for upgrade v3.0.4`

&#x20;When the sync stops for an upgrade (at the heights shown above, you will need to kill the `layerd` process (ctrl^c in many cases) and start it back up again on the corrisponding upgraded binary.\
\
&#xNAN;_&#x4E;ote: Use the v3.0.3 binary at the height for the v3.0.2 upgrade._

{% code overflow="wrap" %}
```sh
# At height 156999:
# change directory
cd ~/layer/binaries/v3.0.2

# resume syncing
./layerd start --price-daemon-enabled=false --home ~/.layer --key-name YOUR_ACCOUNT_NAME

# At height 1185570:
# change directory
cd ~/layer/binaries/v3.0.4

# resume syncing
./layerd start --price-daemon-enabled=false --home ~/.layer --key-name YOUR_ACCOUNT_NAME
```
{% endcode %}
{% endtab %}
{% endtabs %}

To check if the node is fully synced, open a separate terminal window and run:

```sh
./layerd status
```

You should see a JSON formatted list of information about your running node. If you see `catching_up":false` that means that you're node is fully synced and ready to use!
