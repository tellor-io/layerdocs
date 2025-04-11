# Slashing Rules for Validators

### Context

_Tellor inherits validator slashing mechanisms from CometBFT.  A detailed understanding can be found in the_ [_cosmos SDK documentation_](https://docs.cosmos.network/main/build/modules/slashing)_._&#x20;

### Slashing, Jailing, and Tombstoneing

There are two basic reasons that a validator may be automatically slashed, jailed or tombstoned: liveness and double signing.

**Liveness (inactivity):**

If your validator fails to sign for 500 blocks (e.g. the validator node is down for 500 blocks), the validator will be automatically jailed. At the time of writing (layertest-4), it can take 15-25 minutes to produce 500 blocks. The penalty is 1% of bonded tokens. Liveness slashes do not lead to a tombstombing.

If your node is Jailed for inactivity, you can simply "**unjail**" it via cli on the host machine:

{% code overflow="wrap" %}
```bash
./layerd tx slashing unjail --from YOUR_ACCOUNT_NAME --chain-id layertest-4 --fees 5loya --yes
```
{% endcode %}

**Double Signing:**

Unjustified pre-commits (double signs) are rare, and the penalty is severe. If a double sign is detected the validator is automatically slashed up to 50% and tomestoned, while their delegators are forced to unbond or redelegate their token voting power. \
\
A “tombstoned" validator key can never be used again. The validator may rejoin the network using another node key, but they will have to earn back the trust of any delegators they previously had.

{% hint style="danger" %}
Warning: It is possible to double sign blocks accidentally during complex operations like migrating a validator node to a different machine. Always be 100% sure that the layer node process on the old machine is dead before starting it up on the new machine!
{% endhint %}
