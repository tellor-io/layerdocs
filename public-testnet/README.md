# Public Testnet

## Welcome to the Public Testnet Guide



<table data-view="cards"><thead><tr><th></th><th></th><th></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td></td><td></td><td></td><td><a href="run-a-layer-node.md">run-a-layer-node.md</a></td></tr><tr><td></td><td></td><td></td><td><a href="become-a-validator.md">become-a-validator.md</a></td></tr><tr><td></td><td></td><td></td><td><a href="create-a-reporter.md">create-a-reporter.md</a></td></tr></tbody></table>

This guide has three sections:

1. Run a Tellor Layer node.
2. Stake and become a Validator
3. Create a reporter (and unjail if needed)

**Please take the time to review all information in this guide and acclimate yourself before beginning.**

### What is a Validator?&#x20;

Validators in the Tellor Layer network play a crucial role in maintaining the blockchain's integrity and consensus. They are responsible for validating transactions, securing the network, and ensuring the proper functioning of the blockchain.  The number of total validators is capped at 100.

### **Responsibilities of a Validator:**

1. **Transaction Validation:** Validators validate transactions and add them to the chain.
2. **Consensus Participation:** They participate in the consensus mechanism to agree on the state of the chain.
3. **Block Proposal:** Validators propose new blocks and ensure that all committed transactions are included.
4. **Signing:** Validators sign aggregated data values, ensuring their correctness before they are relayed to other chains.

### **Reporters are responsible for:**

* Submitting values for data requests (queries) that are subject to validation and disputes.  \*Validators can be reporters but not all reporters will be validators.

{% hint style="warning" %}
<mark style="color:orange;">**Note:**</mark> _This is a guide for setting up a Tellor Layer public testnet validator / reporter. Care is taken to provide info on the tools being used, but testers should be comfortable with running experimental code via command line interface. A beginner’s understanding of the cosmos SDK is highly recommended!_
{% endhint %}

{% hint style="danger" %}
<mark style="color:red;">**Disclaimer:**</mark> Please note that participation in the Tellor Layer public testnet involves using experimental software. While this environment is intended for testing purposes, users should be aware that if they intend to participate in mainnet validating or reporting on Tellor Layer, they will incur fees and be required to stake TRB. This process carries the risk of losing funds if errors are made. Proceed with caution and ensure you understand the responsibilities and risks associated with participation.  **\*Never use accounts / keys / wallets that hold mainnet funds as your address for testing!**
{% endhint %}

