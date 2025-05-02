# Slashing Rules for Validators

### Context

_Tellor inherits validator slashing mechanisms from CometBFT.  A detailed understanding can be found in the_ [_cosmos SDK documentation_](https://docs.cosmos.network/main/build/modules/slashing)_._&#x20;

## Slashing, Jailing, and Tombstoneing

There are two basic reasons that a validator may be automatically slashed, jailed or tombstoned: <mark style="color:yellow;">**liveness**</mark> and <mark style="color:red;">double signing</mark>.

### **Liveness (inactivity):**

If your validator fails to sign for 500 blocks (e.g. the validator node is down for 500 blocks), the validator will be automatically jailed. At the time of writing layertest-4 has a 1.8s average block time, so it takes approximately 15 minutes of inactivity before a validator is jailed.&#x20;

The penalty for inactivity is 1% of bonded tokens. Liveness slashes do not lead to a tombstombing.

If your node is Jailed for inactivity, you can simply "**unjail**" it via cli on the host machine:

**Double Signing:**

Unjustified pre-commits (double signs) are rare, and the penalty is severe. If a double sign is detected the validator is automatically slashed up to 50% and tomestoned, while their delegators are forced to unbond or redelegate their token voting power. \
\
A “tombstoned" validator key can never be used again. The validator may rejoin the network using another node key, but they will have to earn back the trust of any delegators they previously had.

{% hint style="danger" %}
Warning: It is possible to double sign blocks accidentally during complex operations like migrating a validator node to a different machine. Always be 100% sure that the layer node process on the old machine is dead before starting it up on the new machine!
{% endhint %}

## Check Your Validator's Status

You can check your validator's status on the[ block explorer ](https://explorer.tellor.io/validators)or via cli:

```sh
./layerd query staking validator ACCOUNT_NAME
```

"status: 2" means that you are jailed.

## How to Unjail

Unjail your validator with the command:

{% code overflow="wrap" %}
```bash
./layerd tx slashing unjail --from YOUR_ACCOUNT_NAME --chain-id layertest-4 --fees 5loya --yes
```
{% endcode %}
