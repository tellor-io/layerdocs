---
description: Follow these steps to provide tellor data on a new evm chain
icon: diagram-nested
---

# Integrate Tellor on a New Chain

In this guide, we will go through the steps of providing access to tellor data on a new chain. You do not have to perform these steps yourself, and the tellor team would be happy to help if you contact us on [Discord](https://discord.com/invite/tellor) or [this google form](https://docs.google.com/forms/d/e/1FAIpQLSc5YEerq5y5_YBiQg7ZwDVw76o_1KmRmqXvzjeZlfshNKTvaQ/viewform).&#x20;

For those with a do-it-yourself attitude, this guide will involve:

* deploying the TellorDataBridge contract
* deploying an example user contact SimpleLayerUser
* installing the relayer
* running the relayer

{% hint style="danger" %}
Following the steps in this guide does not guarantee access to absolutely secure oracle data. See the [Tellor Security 201](https://tellor.io/blog/layer-security-201/) article for more information.
{% endhint %}

### Clone Tellor and Install

First, clone tellor layer:

```bash
git clone https://github.com/tellor-io/layer.git
```

Move to the evm directory:

```bash
cd layer/evm
```

Install the tellor hardhat project:

```bash
npm i
```

### Deploy Contracts

Create an env file:

```bash
cp .env.example .env
```

Open your new `.env` file and add your ethereum private key and an rpc node url.

Open the `hardhat.config.js` file and add your evm chain information under `networks`. You can use the `sepolia` section as a guide.

#### TellorDataBridge

Now we're going to use deployment scripts to deploy the TellorDataBridge contract. This is the contract responsible for verifying that relayed data is authentic tellor data.

Open the deployment script `./scripts/DeployTellorDataBridge.js`. At the top of the file, you will see a variable `guardianaddress`. You will need to choose an address who is responsible for resetting the TellorDataBridge validator set in the event that it becomes stale (no updates within 21 days). As long as the validator set is always kept up to date in the contract, the guardian will have no special privileges or responsibilities.

\
Set the address to one of your own addresses:

```js
var guardianaddress = "0xYOUR_ADDRESS"
```

You should also update the `PK` and `NODE_URL` variables to match those in your `.env` file.

Now you should be able to deploy the TellorDataBridge contract:

```bash
npx hardhat run scripts/DeployTellorDataBridge.js --network YOUR_NETWORK
```

The following should print in your logs:

```
deploy TellorDataBridge
TellorDataBridge deployed to: 0xYOUR_DATA_BRIDGE_ADDRESS
```

We will use the address `0xYOUR_DATA_BRIDGE_ADDRESS` in the steps below.

#### SimpleLayerUser

Now we will deploy the SimpleLayerUser contract as an example oracle user.

Open the deployment script `./scripts/DeploySimpleLayerUser.js`. Set the TellorDataBridge address

```js
var dataBridgeAddress = "0xYOUR_DATA_BRIDGE_ADDRESS"
```

You will also need a queryId. We will use the ETH/USD spot price queryId in this example.

```js
var queryId = "0x83a7f3d48786ac2667503a61e8c415438ed2922eb86a2906e4ee66d9a2ce4992"
```

Update the `PK` and `NODE_URL` variables to match those in your `.env` file.

Now we are ready to deploy the SimpleLayerUser:

```bash
npx hardhat run scripts/DeploySimpleLayerUser.js --network YOUR_NETWORK
```

This will print in your logs:

```
deploying SimpleLayerUser
SimpleLayerUser deployed to: 0xYOUR_TELLOR_USER_ADDRESS
```

We will use `0xYOUR_TELLOR_USER_ADDRESS` when running the relayer below.

### Setup and Run the Relayer

The relayer is used to get oracle data from tellor and submit it to your user contract.

Follow the [setup instructions for the relayer](https://docs.tellor.io/layer-docs/using-tellor-data/relay-data-to-evm-chains). We recommend you set your `ETH_PRIVATE_KEY` in the relayer .env file, using the same evm address you used to deploy the contracts in the steps above. Only the deployer address can initialize the TellorDataBridge contract, but any address can run the relayer after initialization. You should also set the `WEB3_PROVIDER_URL`.

#### Initialize TellorDataBridge

We need to initialize the TellorDataBridge contract with the current tellor validator set information.

```bash
relayer init --data-bridge-address 0xYOUR_DATA_BRIDGE_ADDRESS
```

Now you should be ready to relay data to your contract.

#### Relay Data

```bash
relayer relay --layer-user-address 0xYOUR_TELLOR_USER_ADDRESS --data-bridge-address 0xYOUR_DATA_BRIDGE_ADDRESS --contract-type SimpleLayerUser --sleep-time 3600
```

The relayer should gather tellor oracle data and submit it to your contract. If you see a transaction hash printed in the relayer logs, that's a good sign. Check your evm chain's block explorer to see whether you relayed data successfully.

Given the `sleep-time` argument we entered in that last command, the relayer will continuously submit new oracle data once every hour. You may also see the relayer update the validator set in the TellorDataBridge contract occasionally.
