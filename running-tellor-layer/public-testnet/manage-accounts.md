---
description: >-
  Follow the steps to make a layer account that can be used to receive funds
  from the bridge for transacting on layer.
---

# Managing Accounts

{% hint style="info" %}
<mark style="color:blue;">**Security Tips:**</mark>&#x20;

* When you create a new account with the `layerd keys add`  command, the output will include the mnemonic key. It is important to copy this key securely because it is the only time that mnemonic will be shown otherwise!
* This guide uses the "test" backend for easy compatibility with the reporter daemon. For information about the different (more secure) options, check out these docs.
* Always keep a secure backup of your initial configurations (including the Node key) just in case! A validator is difficult to recover without the node\_key, priv\_validator\_key, and priv\_validator\_state.
* Never use an address that holds real funds for testing.
{% endhint %}

If you do not yet have an account / mnemonic phrase, Generate a new key pair with the command:

```sh
./layerd keys add $ACCOUNT_NAME
```

{% hint style="warning" %}
Be sure to <mark style="color:orange;">**copy the entire output**</mark> with the mnemonic and keep it in a very safe place!
{% endhint %}

If you already have an account, you can Import it with the command:

{% code overflow="wrap" %}
```sh
./layerd keys add $ACCOUNT_NAME --recover=true
```
{% endcode %}

To print the "tellor" prefix address to the terminal:

```bash
./layerd keys show $ACCOUNT_NAME
```

Next, add the `--bech val` flag to get the "tellorvaloper" prefix address, which is used for validator commands:

```bash
./layerd keys show $ACCOUNT_NAME --bech val
```

It can be useful to add these addresses to your `.bashrc` or `.zshrc` file. Be sure to replace `your_tellor_prefix_address` and `your_tellorvaloper_prefix_address` in your command:

{% code overflow="wrap" %}
```bash
echo 'export TELLOR_ADDRESS=your_tellor_prefix_address' >> ~/.bashrc #.zshrc if mac
echo 'export TELLORVALOPER_ADDRESS=your_tellorvaloper_prefix_address' >> ~/.bashrc #.zshrc if mac
```
{% endcode %}

Restart your terminal, or use `source ~/.bashrc` before you continue. (if Linux)&#x20;

Restart your terminal, or use `source ~/.zshrc` before you continue. (if mac)

{% hint style="info" %}
<mark style="color:blue;">Check accounts any time with:</mark> \
`./layerd keys list`
{% endhint %}
