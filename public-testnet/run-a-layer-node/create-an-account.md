# Create an Account

{% hint style="info" %}
You will need a "wallet" account on layer to run a node even if you do not intend to recieve tokens or create a validator. (The `--key-name` flag is required when starting layerd.)
{% endhint %}

{% hint style="info" %}
<mark style="color:blue;">**Security Tips:**</mark> \
1\. This guide uses the "test" backend because this is a testnet guide. Always use a secure [keyring-backend option like os, file, or pass](https://docs.cosmos.network/v0.46/run-node/keyring.html) if you're handling real money.\
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

8. **Export your addresses.** (optional but recommended for less experienced users) Your wallet account has two important addresses. First, get the "tellor" prefix address, which is used to send and receive tokens. Copy it and keep it in a safe place:

```bash
./layerd keys show $ACCOUNT_NAME
```

Next, add the `--bech val` flag to get the "tellorvaloper" prefix address, which is used for validator commands. Copy it and keep it in a safe place:

```bash
./layerd keys show $ACCOUNT_NAME --bech val
```

Add these addresses to your `.bashrc` or `.zshrc` file. Be sure to replace `your_tellor_prefix_address` and `your_tellorvaloper_prefix_address` in your command:

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
