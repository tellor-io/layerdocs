# Run a Layer Node

#### Pre-requisites

* A local or cloud system running linux (or mac os with the mac scripts)
* Golang v1.22 (install instrauctions [here](https://go.dev/doc/install))
* jq, yq, and sed for running the scripts:
  * Install jq
    * For mac: brew install jq
    * For linux Ubuntu: sudo apt-get install jq
  * Install yq
    * For mac: brew install yq
    * For linux Ubuntu: sudo apt-get install yq
  * Install sed
    * For mac: brew install sed
    * For linux: sudo apt-get install sed

### Part 1: Run a Layer Node

#### **Steps for Starting a Layer Node Using the Provided Shell Scripts**

{% hint style="warning" %}
<mark style="color:blue;">**Note:**</mark> <mark style="color:blue;">The test backend is not recommended for production use with real funds. Always handle mnemonics/keys with extreme care, even if it’s just a testnet address.</mark>
{% endhint %}

1. **Clone the Layer Repository:**

```sh
git clone https://github.com/tellor-io/layer -b public-testnet
```

2. **Change Active Directory:**

```sh
cd layer
```

3. **Create a file named** `secrets.json` in the layer folder.
4. **Set an alchemy api key for eth rpc.**\
   The file, secrets.json, should contain a single line (replace with your own Alchemy API key): \\

```json
{
"eth_api_key": "your_api_key"
}
```

5. **Open the Script:** Using your favorite text editor (like nano, vim, or code), open:

```sh
layer_scripts/join_chain_new_node_linux.sh
```

Note: If you're using a mac, use the corrisponding scripts for mac. If windows, use the linux scripts with Ubuntu or Debian WSL.

6.  **Edit Variables:**

    * `LAYER_NODE_URL`: Set to the unquoted URL (or public IPv4 address) of a seed node, like tellornode.com.
    * `KEYRING_BACKEND`: Set to `test` by default but can be configured here. (test works fine)
    * `NODE_MONIKER`: Set to whatever you use for the node name + “moniker” at the end (e.g., “billmoniker”).
    * `NODE_NAME`: Set to your name or whatever name you choose (e.g., “bill”).
    * `TELLORNODE_ID`: Set to the unquoted node ID of the seed node.
    * `LAYERD_NODE_HOME`: Should be set to "$HOME/.layer/$NODE\_NAME"

    Note: The provided node ID will be incorrect if the test chain was restarted. This can be checked by running:

```sh
curl tellornode.com:26657/status
```

7. **Important Things to Know Before Running the Script:**
   * When you start the script (which you haven't done yet),_**a test wallet key pair/mnemonic will be created and printed in the terminal. You will need this address to run your validator. There will be a pause allowing you to copy it before it's burried by the node log.**_ It will look something like this:

```sh
    - address: tellor1mh2ua3w8yq5ldeewsdhpg0cazhr7gtcllr6j0j
    name: bill
    pubkey: '{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"Ag+lE4VGW6CpE/TiMnb3zJ6pyETVHobj5Bd5F3OuRW7/"}'
    type: local


    **Important** write this mnemonic phrase in a safe place.
    It is the only way to recover your account if you ever forget your password.

    eagle actress venue redacted style redacted potato still redacted final redacted increase redacted parent panda vapor redacted redacted twelve summer redacted redacted redacted redacted
```

_The script should only be run once, or if you want to start over from scratch! It is intended to be used to delete your old chain and to configure the chain and start it all at once (for testing). Once your node is running, it can be restarted with a `./layerd start` command like the last command in start script._

8.  **Run the Script:**

    * Give the script permission to execute:

    ```sh
    chmod +x layer_scripts/join_chain_new_node_linux.sh
    ```

    *   Run it:

        ```sh
        ./layer_scripts/join_chain_new_node_linux.sh
        ```
    * Wait for the chain to sync. Some errors are expected as the chain starts up, but the log should start moving very quickly once the node starts downloading blocks.
    * Once the log slows down again, it is likely synced. You can verify that your node is synced using:

    ```
    curl localhost:26657/status
    ```

    If `sync_info.catching_up` is `False`, the node is synced! Well done!

{% hint style="info" %}
Make sure to keep your node running before moving on to setting up a validator!
{% endhint %}

