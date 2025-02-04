---
description: How to set up a Tellor Layer Node.
---

# Node Setup

{% hint style="info" %}
<mark style="color:blue;">Notes:</mark> Steps may have multiple options. Be sure to choose the tab that matches your machine / desired setup.
{% endhint %}

### Recommended Machine Specs

Running a node for development or as a personal RPC can be done using any modern pc with at least 16gb ram.

**If running a validator / reporter:**

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

* **Golang** (install latest version [here](https://go.dev/doc/install))
* **jq :** `sudo apt install jq`
* **yq :** `sudo apt install yq`
* **sed :** `sudo apt install sed`
{% endtab %}

{% tab title="MacOS" %}
Golang is required for running layer. jq, yq, and sed are required for running the various config scripts:&#x20;

* **Golang** (install latest version [here](https://go.dev/doc/install))
* **jq:** `brew install jq`
* **yq:** `brew install yq`
* **sed:** `brew install sed`
{% endtab %}
{% endtabs %}

### Build and Configure layerd

1. **Clone the Layer repo, change directory to `layer`**

{% tabs %}
{% tab title="syncing from Genesis" %}
```sh
git clone https://github.com/tellor-io/layer -b v3.0.1 && cd layer
```
{% endtab %}

{% tab title="Snapshot Sync" %}
```sh
git clone https://github.com/tellor-io/layer -b v2.0.1-fix && cd layer
```
{% endtab %}
{% endtabs %}

2. **Build `layerd` with the command:**

```sh
go build ./cmd/layerd
```

3. **Configure system variables with RPC url and contract address for the bridge.**\
   Using your favorite text editor, upen up your `.bashrc` or `.zshrc` file.

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

Add these lines to the bottom of the file. Be sure to replace the example URL with your Sepolia testnet RPC url. (If you're using systemd, be sure to make them part of your start script or .service file):

```bash
# layer
export ETH_RPC_URL='https://any_good_sepolia_rpc_url'
export TOKEN_BRIDGE_CONTRACT="0x6ac02f3887b358591b8b2d22cfb1f36fa5843867"
export WITHDRAW_FREQUENCY="21600"
export REPORTERS_VALIDATOR_ADDRESS="tellor1t6llaazgletpqal2l37emag8x2z053mvxlzskq"
```

Exit nano with `ctrl^x` then enter `y` to save the changes.

4. **Initialize .layer folder in your home directory**

{% code fullWidth="false" %}
```sh
./layerd init layer --chain-id layertest-3
```
{% endcode %}

5. **Configure layer for the layertest-3 test network. This is done using a shell script.**&#x20;

{% tabs %}
{% tab title="Linux" %}
* Create the script file for setting up on linux. We'll use nano in this example:

```sh
nano configure_layer_nix.sh
```

* Open a browser, navigate to the layer repo, and grab [the latest setup script](https://github.com/tellor-io/layer/tree/main/layer_scripts). Or copy it from [here](https://raw.githubusercontent.com/tellor-io/layer/refs/heads/main/layer_scripts/configure_layer_linux.sh).
* Paste the code, then exit nano with `ctrl^x` then enter `y` to save the changes.

Give your new script permission to execute and run it to replace the default configs with proper layer chain configs:

```sh
chmod +x configure_layer_nix.sh && ./configure_layer_nix.sh
```
{% endtab %}

{% tab title="MacOS" %}
* Create the script file for setting up on mac. We'll use nano in this example:

```sh
nano configure_layer_mac.sh
```

* Open a browser, navigate to the layer repo, and grab [the latest setup script](https://github.com/tellor-io/layer/tree/main/layer_scripts). Or copy it from [here](https://raw.githubusercontent.com/tellor-io/layer/refs/heads/main/layer_scripts/configure_layer_mac.sh).
* Paste the code, then exit nano with `ctrl^x` then enter `y` to save the changes.

Give your new script permission to execute and run it to replace the default configs with proper layer chain configs:

```sh
chmod +x configure_layer_mac.sh && ./configure_layer_mac.sh 
```
{% endtab %}
{% endtabs %}

You're now ready to start syncing your node.

## Choose How you will Sync your Node

There are two basic ways to sync your node. Choose your adventure:

* **genesis sync (**[**see steps here**](genesis-sync-no-cosmovisor.md)**)**
* **snapshot sync (**[**see steps here**](./#snapshot-sync)**)**

_Note: genesis sync steps are not needed and are not compatible with a snapshot sync. likewise, the snapshot sync steps are not compatible with a genesis sync._&#x20;

Additionally cosmovisor can be used to help make upgrades automatic. An example of a [cosmovisor setup can be found here.](cosmovisor-sync.md)
