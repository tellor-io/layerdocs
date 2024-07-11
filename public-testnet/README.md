# Public Testnet

## Join the Public Testnet

**In this guide we we'll cover the necessary steps to:**

1. Configure a Tellor Layer node and join the network using setup scripts.
2. Use the node to stake test TRB as a **Layer validator** and earn rewards.

{% hint style="warning" %}
**Note:** This is a guide for setting up a Tellor Layer public testnet node. Care is taken to provide clarity on the tools being used, but testers should be comfortable with running experimental code via command line interface. A beginner’s understanding of the cosmos SDK is highly recommended!&#x20;
{% endhint %}

{% hint style="info" %}
**Note:** Oracle data reporting is not ready for public testing at this time.
{% endhint %}

{% hint style="danger" %}
**Disclaimer:** Please note that participation in the Tellor Layer public testnet involves using experimental software. While this environment is intended for testing purposes, users should be aware that if they intend to participate in mainnet validating or reporting on Tellor Layer, they will incur fees and be required to stake TRB. This process carries the risk of losing funds if errors are made. Proceed with caution and ensure you understand the responsibilities and risks associated with participation.  **\*Never use accounts / keys / wallets that hold mainnet funds as your address for testing!**
{% endhint %}

#### What is a Validator?&#x20;

Validators in the Tellor Layer network play a crucial role in maintaining the blockchain's integrity and consensus. They are responsible for validating transactions, securing the network, and ensuring the proper functioning of the blockchain.  The number of total validators is capped at 100.

**Responsibilities of a Validator:**

1. **Transaction Validation:** Validators validate transactions and add them to the chain.
2. **Consensus Participation:** They participate in the consensus mechanism to agree on the state of the chain.
3. **Block Proposal:** Validators propose new blocks and ensure that all committed transactions are included.
4. **Signing:** Validators sign aggregated data values, ensuring their correctness before they are relayed to other chains.



### &#x20;
