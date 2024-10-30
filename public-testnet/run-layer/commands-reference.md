---
description: Example commands for common actions with all required flags.
---

# Commands Reference

To start layer as a validator /reporter:

{% code overflow="wrap" %}
```sh
./layerd start --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false --key-name $ACCOUNT_NAME
```
{% endcode %}

Start layer with cosmovisor:

{% code overflow="wrap" %}
```sh
./cosmovisor run start --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false --key-name $ACCOUNT_NAME
```
{% endcode %}
