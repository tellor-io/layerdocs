# Initial Setup

### Build and Configure layerd

There are 9 steps in this part.

1. **Clone the Layer repo, change directory to `layer`**

```sh
git clone https://github.com/tellor-io/layer -b v0.6.1 && cd layer
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

Add this line to the end of this file. Edit the ACCOUNT\_NAME to whatever you'd like to call your wallet account:

```sh
# layer
export ACCOUNT_NAME="not_spuddy"
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

    You're now ready to start your node with default sync settings. If you want to do a state sync, do the additional config steps [here](state-sync-setup-optional.md) before you continue. \

7. Start a layer node for development:

```
./layerd start
```
