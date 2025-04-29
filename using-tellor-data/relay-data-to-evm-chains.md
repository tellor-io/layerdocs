---
description: >-
  Relay oracle data, validator set, and bridge information updates back and
  forth between tellor layer and any EVM chain.
icon: microchip
---

# Relay Data to EVM Chains

The [relayer](https://github.com/tellor-io/py-relayer) queries tellor for oracle data and their proofs and submits them to a user contract on other chains.

### Setup

1. Clone the repo:

```bash
git clone https://github.com/tellor-io/py-relayer.git
```

2. Navigate to the repository directory:

```bash
cd py-relayer
```

3. Create a virtual environment:

```bash
python3 -m venv venv
source venv/bin/activate
```

4. Install the dependencies:

```bash
pip install -r requirements.txt
```

5. Install the package:

```bash
pip install -e .
```

6. Copy the .env.example file to .env and set the appropriate environment variables:

```bash
cp .env.example .env
```

The "email" section of the .env file is optional. If you want to receive emails when layer is down, input your gmail username and password. We recommend using an [app password](https://support.google.com/accounts/answer/185833?hl=en) for your gmail account.

Other than the email section, all .env variables can alternatively be set through the CLI. We recommend setting your ethereum private key in the .env file for security reasons. For convenience, you should set any parameters which tend to remain constant across runs in the .env file. CLI arguments will override .env variables.

#### Additional Requirements for Ubuntu

If you are running the relayer on ubuntu, you may need to install additional tools:

```bash
sudo apt update
sudo apt install build-essential python3-dev
```

After installing these dependencies, proceed with the setup instructions above.

### Usage

The relayer provides several commands through its CLI:

#### Start Relaying

```bash
relayer relay --layer-test-user-address 0x44941f399c4c009b01bE2D3b0A0852dC8FFD2C4a --blobstream-address 0xC69f43741D379cE93bdaAC9b5135EA3e697df1F8 --layer-swagger https://node-palmito.tellorlayer.com/ --layer-rpc https://node-palmito.tellorlayer.com/rpc/ --contract-type TestPriceFeedUser --sleep-time 7200
```

#### Update Oracle Data Once

```bash
relayer update --query-id 0x83a7f3d48786ac2667503a61e8c415438ed2922eb86a2906e4ee66d9a2ce4992
```

#### Relay Token Bridge Withdraw

```bash
relayer relay-bridge --blobstream-address 0xC69f43741D379cE93bdaAC9b5135EA3e697df1F8 --token-bridge-address 0x5acb5977f35b1A91C4fE0F4386eB669E046776F2 --withdraw-id 8
```

#### Initialize Blobstream

This command initializes the BlobstreamO contract after deployment. This must be run by the contract deployer address.

```bash
relayer init
```

#### Reset Blobstream

This command resets the validator set in the BlobstreamO contract in the event that the last relayed validator set is over 21 days old. This can only be run by the BlobstreamO contract’s `guardian` address.

```bash
relayer reset
```

To see all available options for each command:

```bash
relayer --help
relayer relay --help
```

.

