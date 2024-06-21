# Local Testing

## Tellor Layer Public Testnet Guide: Running a Validator Locally

This guide will walk you through setting up and running a validator locally for the Tellor Layer Public Testnet. Ensure you meet the requirements and follow the steps carefully.

{% hint style="warning" %}
### Requirements

* `sed`
* `jq`
* `go` (v1.22)
{% endhint %}

### Step 1: Creating a New Node

#### Setup

1. **Screen Sessions**: If using one terminal instance, use screen sessions to manage multiple tasks.
   *   Install screen if not already installed:

       ```sh
       sudo apt-get install screen
       ```
2. **Set Up Node URL**: Choose an RPC URL of an existing node and set the `LAYER_NODE_URL` variable without quotes.
   *   Example:

       ```sh
       export LAYER_NODE_URL=tellor-example-node.com
       ```
3.  **Get Node Status**: Verify the node status by calling the status endpoint:

    ```sh
    curl tellor-example-node.com:26657/status
    ```

    *   This should return a JSON response similar to:

        ```json
        {
          "jsonrpc": "2.0",
          "id": -1,
          "result": {
            "node_info": {
              "protocol_version": {
                "p2p": "8",
                "block": "11",
                "app": "0"
              },
              "id": "f5f6ce5d15ea80683b9133b19e245f9b27daab67",
              "listen_addr": "tcp://0.0.0.0:26656",
              "network": "layer",
              "version": "0.38.7",
              "channels": "40202122233038606100",
              "moniker": "alicemoniker",
              "other": {
                "tx_index": "on",
                "rpc_address": "tcp://0.0.0.0:26657"
              }
            },
            "sync_info": {
              "latest_block_hash": "5CD20D6553DDBE078EB43AC970F6D391F8FDFB2D2BD968F7B1A7454AA05154C5",
              "latest_app_hash": "847D19668188D482BFAA8808FB6207315F0766098A9202103F33DF51070027A5",
              "latest_block_height": "73830",
              "latest_block_time": "2024-06-04T15:38:53.899045777Z",
              "earliest_block_hash": "EACF6AFE38ABB21E97078359EFAAD7E61D0417BBBA2C7724BB042D38F73693E1",
              "earliest_app_hash": "E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855",
              "earliest_block_height": "1",
              "earliest_block_time": "2024-06-03T17:59:53.991818534Z",
              "catching_up": false
            },
            "validator_info": {
              "address": "BEBEAE312EEE6AAD0E315FC6A36C9C44BDCEA1D3",
              "pub_key": {
                "type": "tendermint/PubKeyEd25519",
                "value": "0/8w6RR2ZiQLwdbn1QvwrxYSfGUtW7jXTyPOL9a9NiY="
              },
              "voting_power": "100000"
            }
          }
        }
        ```
4. **Set Node ID**: Use the `node_info.id` value to set the `TELLORNODE_ID` variable without quotes.
   *   Example:

       ```sh
       export TELLORNODE_ID=f5f6ce5d15ea80683b9133b19e245f9b27daab67
       ```
5. **Set Node Name and Moniker**: Choose a name and moniker for your node. This will be used to name the folder for your node configuration.
   *   Set the `LAYERD_NODE_HOME` variable:

       ```sh
       export LAYERD_NODE_HOME="$HOME/.layer/$NODE_NAME"
       ```
6.  **Run the Setup Script**: Execute the setup script from the base layer folder to start the chain and sync your node:

    ```sh
    sh ./layer_scripts/{selected_version_of_script}.sh
    ```

### Step 2: Creating a Validator

#### Prerequisites

Ensure you have a running and synced node.

#### Setup

1. **Set Variables**: Use the same values as for creating your node.
2. **Stake TRB**: Select the amount of TRB you want to receive from the faucet and stake for the new validator (1 TRB = 1e1\*6 loya).
3.  **Run Validator Script**: Execute the script to create a new validator:

    ```sh
    sh ./layer_scripts/create_new_validator_{OS}.sh
    ```

#### Verify Validator Status

1. **Monitor Output**: Ensure the returned validator info shows `"status": 3`. If not, cancel the script with `CTRL-C`.
2. **Restart Chain as Validator**:
   * When prompted by the script, go to the terminal or screen session where your current node is running.
   * Stop the chain using `CTRL-C`.
   * The script will restart the chain/node as a validator.

You have now successfully set up and started running a validator locally for the Tellor Layer Public Testnet. For more information and support, refer to the Tellor Layer documentation and community channels.
