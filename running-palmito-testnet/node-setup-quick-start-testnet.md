---
description: Use the guided setup shell scripts!
icon: person-running-fast
---

# Node Setup Quick Start (testnet)

### 1. Install Prerequisites:

{% tabs %}
{% tab title="Linux" %}
jq, yq, sed, curl, wget, make, and **Go** are required for running the various commands and config scripts and commands in this guide:&#x20;

* **`jq` :** `sudo apt install jq`
* **`sed` :** `sudo apt install sed`
* **`curl`**: `sudo apt install curl`
* **`wget`** : `sudo apt install wget`
{% endtab %}

{% tab title="MacOS" %}
jq, yq, sed, curl, wget, make, and **Go** are required for running the various commands and config scripts and commands in this guide:&#x20;

* **`jq`:** `brew install jq`
* **`sed`:** `brew install sed`
* **`wget`**`: brew install wget` &#x20;
{% endtab %}
{% endtabs %}

Download the latest binary:

{% tabs %}
{% tab title="Linux" %}
<pre class="language-sh" data-overflow="wrap"><code class="lang-sh"><strong>mkdir -p ~/layer/binaries &#x26;&#x26; cd ~/layer/binaries &#x26;&#x26; mkdir v5.1.0 &#x26;&#x26; cd v5.1.0 &#x26;&#x26; wget https://github.com/tellor-io/layer/releases/download/v5.1.0/layer_Linux_x86_64.tar.gz &#x26;&#x26; tar -xvzf layer_Linux_x86_64.tar.gz
</strong></code></pre>
{% endtab %}

{% tab title="MacOS" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries && cd ~/layer/binaries && mkdir v5.1.0 && cd v5.1.0 && wget https://github.com/tellor-io/layer/releases/download/v5.1.0/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz
```
{% endcode %}
{% endtab %}
{% endtabs %}

### 2. Download the script that matches your system:

Additional info about the scripts can be found [here](https://github.com/tellor-io/layer/tree/main/scripts/setup). We will give the script permission to execute in the same command.

{% tabs %}
{% tab title="Linux" %}
{% code overflow="wrap" %}
```sh
wget https://raw.githubusercontent.com/tellor-io/layer/refs/heads/main/scripts/setup/initial_config/configure_palmito_linux.sh && chmod +x configure_palmito_linux.sh
```
{% endcode %}
{% endtab %}

{% tab title="Mac" %}
{% code overflow="wrap" %}
```sh
wget https://raw.githubusercontent.com/tellor-io/layer/refs/heads/main/scripts/setup/initial_config/configure_palmito_mac.sh && chmod +x configure_palmito_mac.sh
```
{% endcode %}
{% endtab %}
{% endtabs %}

### 3. Edit the environment variables (optional)

If you'd like to use a custom home directory, custom peers or RPCs you can configure those at the top of the script. The defaults are:

```sh
# ...
export LAYER_NODE_URL=https://node-palmito.tellorlayer.com/rpc/
export RPC_NODE_ID=ac7c10dc3de67c4394271c564671eeed4ac6f0e0
export KEYRING_BACKEND="test"
export PEERS="8d19cdf430e491d6d6106863c4c466b75a17088a@54.153.125.203:26656,c7b175a5bafb35176cdcba3027e764a0dbd0811c@34.219.95.82:26656,05105e8bb28e8c5ace1cecacefb8d4efb0338ec6@18.218.114.74:26656,705f6154c6c6aeb0ba36c8b53639a5daa1b186f6@3.80.39.230:26656,1f6522a346209ee99ecb4d3e897d9d97633ae146@3.101.138.30:26656"
export LAYER_HOME="/home/$(logname)/.layer"
export STATE_SYNC_RPC="https://node-palmito.tellorlayer.com/rpc/"
export KEY_NAME="test"
# ...
```

Use your favorite text editor to change these before running the script if desired.

```sh
nano configure_palmito_linux.sh # if linux
# --or--
nano configure_palmito_mac.sh # if mac
```

### 4. Give the script permission to execute, and run it:

<pre class="language-sh"><code class="lang-sh"><strong>./configure_palmito_linux.sh # if linux
</strong># --or--
./configure_palmito_mac.sh # if mac
</code></pre>

The script should greet you and begin the guided setup!

<figure><img src="../.gitbook/assets/Screenshot From 2025-07-31 10-05-08.png" alt=""><figcaption></figcaption></figure>
