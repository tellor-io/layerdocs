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
git clone https://github.com/tellor-io/layer -b v1.5.0 && cd layer
```

2. **Build layerd with the command:**

```sh
go build ./cmd/layerd
```

3. **An ethereum RPC is requred for reporting bridge requests on layer.**\
   Using your favorite text editor, create a file called `secrets.yaml`:

```sh
nano secrets.yaml.example
```

Replacing \`your\_sepolia\_testnet\_rpc\_url\` with the url of a reliable sepolia rpc, and add the token bridge contract address as shown here:

```json
eth_rpc_url: "wss://your_sepolia_testnet_rpc_url"
token_bridge_contract: "0x31F1f15541ea781e170F40A3eEdcfcaC837aFa12"
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

    You're now ready to start your node with default sync settings.

_<mark style="color:green;">**Before starting your node**</mark><mark style="color:green;">,</mark> it's a good idea to think about how you want to run it so that the process does not get killed accidentally._ [_GNU screen_](https://tellor.io/blog/how-to-manage-cli-applications-on-hosted-vms-with-screen/) _is a great option for beginners. More advanced setups can be achieved using systemd._

6. Start your layer node:

```
./layerd start
```

You should now see your log quickly downloading blocks!

8. Check if you're fully synced. Open another terminal window and use the command:

```
./layerd status
```

You should see a json formated list of information about your running node. If you see `catching_up":false}` that means that you're node is fully synced and ready to use!