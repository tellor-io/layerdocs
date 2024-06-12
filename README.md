# Tellor Layer Documentation

## Overview <a href="#overview" id="overview"></a>

Tellor Layer is a stand alone L1 built using the cosmos sdk for the purpose of coming to consensus on any subjective data. It works by using a network of staked parties who are crypto-economically incentivized to honestly report requested data.

For more in-depth information, checkout the [Tellor Layer tech paper](https://github.com/tellor-io/layer/blob/main/TellorLayer%20-%20tech.pdf) and our [ADRs](https://github.com/tellor-io/layer/tree/main/adr).

### Starting a New Chain:

1. Select the start script that works for you

* `start_one_node.sh` is for those who want to run a chain with a single validator in a mac environment
* `start_one_node_aws.sh` is for those who want a chain with a single validator and the option to import a faucet account from a seed phrase to be used in a linux environment
* `start_two_chains.sh` (mac environment) sets up two nodes/validators and starts one of them from this script. Then to start the other validator you would run the `start_bill.sh` script

2. Run the selected script from the base layer folder: `sh ./start_scripts/{selected_script}`

### Joining a Running Chain:

To find more information please go to the layer\_scripts folder.

Here you will find a detailed breakdown for how to join a chain as a node and how to create a new validator for the chain

### Tests

To run all tests: `go test -v ./...`

### Linting

To lint per folder: `make lint-folder-fix FOLDER="x/mint"`

To lint all files: `make lint`

### Maintainers <a href="#maintainers" id="maintainers"></a>

This repository is maintained by the [Tellor team](https://github.com/orgs/tellor-io/people)

### How to Contribute <a href="#how2contribute" id="how2contribute"></a>

Check out our issues log here on Github or feel free to reach out anytime [info@tellor.io](mailto:info@tellor.io)

### Community <a href="#community" id="community"></a>

* [Official Website](https://tellor.io/)
* [Discord](https://discord.gg/n7drGjh)
* [Twitter](https://twitter.com/wearetellor)

### Copyright <a href="#copyright" id="copyright"></a>

Tellor Inc. 2024
