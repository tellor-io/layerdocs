---
description: How to set up a Tellor Layer Node.
---

# Node Setup

{% hint style="info" %}
<mark style="color:blue;">Note:</mark> Steps may have multiple options. Be sure to choose the tab that matches your machine / desired setup.
{% endhint %}

### Recommended Machine Specs

Running a node for development or as a personal RPC can be done using any modern pc with at least 16gb ram.

**If running a validator / reporter:**

* Modern cpu with at least 8 cores / threads
* ram: 32 gb
* storage: 500gb+ @ nvme gen3
* network: 500mb/s DL, 100mb/s UL (the faster the better)&#x20;

### Pre-requisites

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
git clone https://github.com/tellor-io/layer -b v2.0.0-alpha1 && cd layer
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
export TOKEN_BRIDGE_CONTRACT="0xFC1C57F1E466605e3Dd40840bC3e7DdAa400528c"
```

Exit nano with `ctrl^x` then enter `y` to save the changes.

4. **Initialize .layer folder in your home directory**

{% code fullWidth="false" %}
```sh
./layerd init layer --chain-id layertest-2
```
{% endcode %}

5. **Configure layer for the layertest-2 test network. This is done using a shell script.**&#x20;

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

_<mark style="color:green;">**Before starting your node**</mark><mark style="color:green;">,</mark> it's a good idea to think about how you want to run it so that the process does not get killed accidentally._ [_GNU screen_](https://tellor.io/blog/how-to-manage-cli-applications-on-hosted-vms-with-screen/) _is a great option for beginners. More advanced setups can be achieved using systemd._

{% hint style="info" %}
_**If you want to do a state sync, do not start your node yet!**_ \
_**Go**_ [_**here**_](state-sync-setup-optional.md) _**and do the**_ [_**State Sync Setup Steps.**_](state-sync-setup-optional.md)
{% endhint %}

{% hint style="info" %}
If you want to do a genesis sync (takes longer but it always works), continue with the steps below.
{% endhint %}

6. Start your layer node:

```bash
./layerd start
```

You should now see your log quickly downloading blocks!

7. perform upgrades:

When syncing the chain from genesis, changing binaries is required. When the chain stops and waits for version v2.0.0-audit, kill your layer process and update your binary in the layer folder:

```bash
# upgrade to version v2.0.0-audit (hotfix commit)
git checkout 634c27667b504beead473321a964aab866866fe3 \
go build ./cmd/layerd
```

The start your layer process up again with `./layerd start`

Let it sync up to the next upgrade, then do the same for version `v2.0.1-fix`:

```bash
# upgrade to version v2.0.1-fix
git checkout main \
git pull \
git checkout v2.0.1-fix \
go build ./cmd/layerd
```

The start your layer process up again with `./layerd start`

7. Check if you're fully synced. Open another terminal window and use the command:

```bash
./layerd status
```

You should see a json formated list of information about your running node. If you see `catching_up":false}` that means that you're node is fully synced and ready to use!
