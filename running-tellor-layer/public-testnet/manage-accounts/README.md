---
description: >-
  Follow the steps to make a layer account that can be used to receive funds
  from the bridge (or the faucet) for transacting on layer.
---

# Manage Accounts

{% hint style="info" %}
<mark style="color:blue;">**Security Tips:**</mark> \
1\. This guide uses the "test" backend because this is a testnet guide. Use a more secure option if you're handling real money.\
2\. Handle mnemonics/keys with extreme care, even if it’s just a testnet address.\
3\. Never use an address that holds real funds for testing.
{% endhint %}

If you do not yet have an account / mnemonic phrase, Generate a new key pair with the command:

```sh
./layerd keys add $ACCOUNT_NAME
```

{% hint style="warning" %}
Be sure to <mark style="color:orange;">**copy the entire output**</mark> with the mnemonic and keep it in a very safe place!
{% endhint %}

If you already have an account, you may Import it with the command:

{% code overflow="wrap" %}
```sh
./layerd keys add $ACCOUNT_NAME --recover=true
```
{% endcode %}

**Export your addresses.** (optional but recommended for less experienced users) Your wallet account has two important addresses. First, get the "tellor" prefix address, which is used to send and receive tokens. Copy it and keep it in a safe place:

```bash
./layerd keys show $ACCOUNT_NAME
```

Next, add the `--bech val` flag to get the "tellorvaloper" prefix address, which is used for validator commands. Copy it and keep it in a safe place:

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

Restart your terminal, or use `source ~/.bashrc` before you continue. (if Linux) Restart your terminal, or use `source ~/.zshrc` before you continue. (if mac)

{% hint style="info" %}
<mark style="color:blue;">Check accounts any time with:</mark> \
`./layerd keys list`
{% endhint %}
