---
description: Using the Tellor layer node installation script!
icon: person-running-fast
---

# Quick Start New (faster!)

{% hint style="info" %}
These commands will work on linux only. You will need to adjust the individual commands yourself for use on macOS.
{% endhint %}

### 1. Install Prerequisites:

{% tabs %}
{% tab title="Debian / ubuntu" %}
jq, yq, sed, curl, wget, make, and **Go** are required for running the various commands and config scripts and commands in this guide:

```bash
sudo apt install jq curl wget sed
```
{% endtab %}
{% endtabs %}

### 2. Download Layer installation script:

{% tabs %}
{% tab title="Linux" %}
Download the layer node installation script and give it permission to execute:

{% code overflow="wrap" %}
```sh
wget https://raw.githubusercontent.com/tellor-io/layer/refs/heads/main/scripts/setup/install_layer.sh && chmod +x install_layer.sh
```
{% endcode %}
{% endtab %}
{% endtabs %}

### 3. Run the Layer Node Installation Script

The script has two arguments `[NETWORK]` and `ACCOUNT_NAME` :

* "NETWORK": (required)  `palmito` for `layertest-4` -OR- `mainnet` for `tellor-1`
* "ACCOUNT\_NAME":  (optional) Set to any name you would like for your initial layer node account.

Run the script with the following command:

<pre class="language-sh"><code class="lang-sh"><strong>./install_layer.sh palmito [account_name]
</strong></code></pre>

