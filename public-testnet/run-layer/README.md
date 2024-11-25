---
description: >-
  Tellor layer is a proof of stake network open to everyone who wants to run a
  validator or be a reporter.
---

# Run Layer

### Pre-requisites

* A local or cloud system running linux, or macOS. If on windows, use WSL.&#x20;
* Golang (install latest version [here](https://go.dev/doc/install))
* jq (`sudo apt install jq` on linux, or `brew install jq` on mac)
* yq (`sudo apt install yq` on linux, or `brew install yq` on mac)
* sed (`sudo apt install sed` on linux, or `brew install sed` on mac)

### Recommended Machine Specs

**If running a node for personal RPC (developer):**

* A modern cpu with at least 4 cores
* ram: 16 gb&#x20;
* storage: 500gb+ (solid state)

**If running a validator / reporter:**

* A modern cpu with at least 8 cores / threads
* ram: 32 gb&#x20;
* storage: 500gb+ @ nvme gen3
* network: 500mb/s DL, 100mb/s UL (the faster the better)

{% hint style="info" %}
## Initial Setup&#x20;
{% endhint %}

### Build and Configure layerd

There are 9 steps in this part.

1. **Clone the Layer repo, change directory to `layer`**

```sh
# for genesis sync
git clone https://github.com/tellor-io/layer -b v2.0.0-alpha1 && cd layer
```

2. **Build `layerd` with the command:**

```sh
go build ./cmd/layerd
```

3. **Configure system variables with RPC url and contract address for the bridge.**\
   Using your favorite text editor, upen up your `.bashrc` or `.zshrc` file:

```sh
# if linux
nano ~/.bashrc

#if mac
nano ~/.zshrc
```

Add these lines to the bottom of the file. Be sure to replace the example URL with your Sepolia testnet RPC url:

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

6.  **Create and Run the configure\_layer script**\
    We need to change the config files a bit using one of the provided `configure_layer_nix.sh` or `configure_layer_mac.sh` scripts from the layerdocs repo.

    **If on linux:**

    * create the script file locally:

    ```sh
    nano configure_layer_nix.sh # or configure_layer_mac.sh if mac
    ```

    * Navigate [here](https://raw.githubusercontent.com/tellor-io/layerdocs/update-guide-working/public-testnet/configure_layer_nix.sh), select all and copy the code to your clipboard.&#x20;
    * Paste the code, then exit nano with `ctrl^x` then enter `y` to save the changes.

    **If on Mac:**

    * create the script file locally:

    ```sh
    nano configure_layer_mac.sh # or configure_layer_mac.sh if mac
    ```

    * Navigate [here](https://raw.githubusercontent.com/tellor-io/layerdocs/update-guide-working/public-testnet/configure_layer_mac.sh), select all and copy the code to your clipboard.
    * Paste the code, then exit nano with `ctrl^x` then enter `y` to save the changes.

    Give your new script permission to execute and run it to replace the default configs with proper layer chain configs:

    ```sh
    # if linux
    chmod +x configure_layer_nix.sh && ./configure_layer_nix.sh

    # if mac
    chmod +x configure_layer_mac.sh && ./configure_layer_mac.sh 
    ```

    You're now ready to start your node with default sync settings.

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

7. Upgrade the binary when syncing halts. The binary that you need will be visible in the log.

```bash
# for binary v1.6.0
git checkout main && git pull && git checkout v1.6.0 && go build ./cmd/layerd
```

After you build the new binary, kill and restart your node.\
&#xNAN;_&#x54;his must be done for all upgrades since genesis._

7. Check if you're fully synced. Open another terminal window and use the command:

```bash
./layerd status
```

You should see a json formated list of information about your running node. If you see `catching_up":false}` that means that you're node is fully synced and ready to use!
