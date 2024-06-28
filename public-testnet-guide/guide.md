# Guide

## The Guide: Starting a Layer Node and Becoming a Validator

**Steps for Starting a Layer Node Using the Provided Shell Scripts**

{% hint style="warning" %}
<mark style="color:blue;">**Note:**</mark> <mark style="color:blue;"></mark><mark style="color:blue;">The test backend is not recommended for production use with real funds. Always handle mnemonics/keys with extreme care, even if it’s just a testnet address.</mark>
{% endhint %}

1.  **Clone the Layer Repository:**

    ```sh
    git clone https://github.com/tellor-io/layer
    ```
2.  **Change Active Directory:**

    ```sh
    cd layer
    ```
3.  **Open the Script:** Using your favorite text editor (like nano, vim, or code), open:

    ```sh
    /layer_scripts/join_chain_new_node_{desired OS}
    ```
4. **Edit the Following Variables:**
   * `LAYER_NODE_URL`: Set to the unquoted URL (or public IPv4 address) of a seed node, like tellornode.com.
   * `KEYRING_BACKEND`: Set to `test` by default but can be configured here.
   * `NODE_MONIKER`: Set to whatever you use for the node name + “moniker” at the end (e.g., “billmoniker”).
   * `NODE_NAME`: Set to your name or whatever name you choose (e.g., “bill”).
   *   `TELLORNODE_ID`: Set to the unquoted node ID of the seed node. The node ID can be found by running:

       ```sh
       curl tellornode.com:26657/status
       ```

       Replace “tellornode.com” with the URL for your seed node if different.
   * `LAYERD_NODE_HOME`: This is set automatically based on your input for `NODE_NAME`. This is the directory where you can find the layer config files and your test key.



1. **Preparation Before Running the Script:**
   *   When you start the script, a test wallet key pair/mnemonic will be created and printed in the terminal. There will be a pause allowing you to copy it before the node log starts up. It will look something like this:

       {% code fullWidth="true" %}
       ```
       - address: tellor1v7pj7k067hzzxxn9nngdg6wfnw978tnyv2e2n
         name: bill
         pubkey: '{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"Ar9mM1r3El8+/qaWT9sVlcHwDwHe/b0iSq4yRSxZnTd"}'
         type: local
       ```
       {% endcode %}
   * Make sure you copy this wallet if you don’t have another plan for creating your validator wallet.
   * The script will start a node with the reporter daemon turned off by default. This is useful for testing if you can successfully run and sync the layer node, participate in consensus, and receive rewards.
2. **Run the Script:**
   *   Give the script permission to run:

       ```sh
       chmod +x /layer_scripts/join_chain_new_node_{linux/mac}.sh
       ```
   *   Run it:

       ```sh
       ./layer_scripts/join_chain_new_node_{linux/mac}.sh
       ```
   * Wait for the chain to sync. Some errors are expected as the chain starts up, but the log should start moving very quickly once the node starts downloading blocks.
   *   Once the log slows down again, it is likely synced. You can verify that your node is synced using:

       ```sh
       curl {localhost/your new node URL}:26657/status
       ```

       If `sync_info.catching_up` is `False`, the node is synced! Well done!

**Steps for Becoming a Validator**

1. **Get Some Layer Testnet TRB:** Request in the public Discord #developers channel or use the token bridge from the Sepolia testnet playground.
2.  **Verify That You Have a Funded Address:**

    ```sh
    curl http://tellornode.com:1317/cosmos/bank/v1beta1/balances/{your address}
    ```
3.  **Retrieve Your Validator Public Key:** With `layer` as the active directory, use the command:

    ```sh
    ./layerd comet show-validator --home ~/.layer/{node_name}
    ```

    This returns your validator pubkey (e.g., `{"@type":"/cosmos.crypto.ed25519.PubKey","key":"FX9cKNl+QmxtLcL926P5yJqZw7YyuSX3HQAZboz3TjM="}`).
4.  **Create a Validator Configuration File:** Create a file named `~/layer/validator.json` and paste the following JSON object into it:

    ```json
    {
        "pubkey": {PASTE THE PUBKEY RETURNED IN STEP 3},
        "amount": "AMOUNT OF LOYA YOU WANT TO STAKE",
        "moniker": "NODE MONIKER",
        "identity": "",
        "website": "",
        "security": "",
        "details": "",
        "commission-rate": "0.1",
        "commission-max-rate": "0.2",
        "commission-max-change-rate": "0.01",
        "min-self-delegation": "1"
    }
    ```
5.  **Create Your Validator:** Run the following command (make sure you leave enough TRB for gas fees):

    ```sh
    ./layerd tx staking create-validator ./validator.json --from {YOUR ADDRESS} --home ~/.layer/{NODE_NAME} --chain-id layer --node="http://tellornode.com:26657"
    ```
6.  **Verify Your Validator Creation:** Ensure your validator was created successfully using the command:

    ```sh
    ./layerd query staking validator $(./layerd keys show $NODE_NAME --bech val --address --keyring-backend $KEYRING_BACKEND --home $LAYERD_NODE_HOME) --output json | jq
    ```

**Additional Resources**

* **Template Checklist:** [Google Sheets Checklist](https://docs.google.com/spreadsheets/d/1wT6nSM60KU6JD5PGHiKxPhUgwL0DQtOC-Rfo6BTitN8/edit#gid=0)
* **Project Checklists Folder:** [Google Drive Folder](https://drive.google.com/drive/u/1/folders/10Ixjl4fP7A7ZT-bPdIeTq9kI9XKkrvx\_)
