---
description: Example commands for upgrading the layerd binary.
---

# Binary Upgrades

Use these steps when Palmito reaches a planned chain upgrade and your node stops at the upgrade height.

If you run your node with cosmovisor, follow the [Cosmovisor Sync](cosmovisor-sync.md) upgrade steps instead.

## 1. Download the new binary

The new `layerd` binary version is `v6.1.6`. Choose the command for your machine:

{% tabs %}
{% tab title="Linux" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries && cd ~/layer/binaries && mkdir v6.1.6 && cd v6.1.6 && wget https://github.com/tellor-io/layer/releases/download/v6.1.6/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz
```
{% endcode %}
{% endtab %}

{% tab title="Linux ARM64" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries && cd ~/layer/binaries && mkdir v6.1.6 && cd v6.1.6 && wget https://github.com/tellor-io/layer/releases/download/v6.1.6/layer_Linux_arm64.tar.gz && tar -xvzf layer_Linux_arm64.tar.gz
```
{% endcode %}
{% endtab %}

{% tab title="MacOS" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries && cd ~/layer/binaries && mkdir v6.1.6 && cd v6.1.6 && wget https://github.com/tellor-io/layer/releases/download/v6.1.6/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz
```
{% endcode %}
{% endtab %}
{% endtabs %}

Confirm the version:

```sh
~/layer/binaries/v6.1.6/layerd version
```

## 2. (optional) Install it in `~/go/bin/layerd`

Copy the new binary into `~/go/bin`:

```sh
mkdir -p ~/go/bin
cp ~/layer/binaries/v6.1.6/layerd ~/go/bin/layerd
chmod +x ~/go/bin/layerd
```

Make sure `~/go/bin` is in your shell `PATH` so new terminal sessions can find `layerd`.
Edit with nano or use the commands below to add `export PATH="$HOME/go/bin:$PATH"` in your `.bashrc` or `.zshrc`

{% tabs %}
{% tab title="bash" %}
```sh
echo 'export PATH="$HOME/go/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```
{% endtab %}

{% tab title="zsh" %}
```sh
echo 'export PATH="$HOME/go/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```
{% endtab %}
{% endtabs %}

Check that your shell is using the new binary:

```sh
which layerd
layerd version
```

## 3. Restart at the upgrade height

The node will stop and wait for the upgraded binary when the upgrade height is reached. When this happens, stop your node process. If you start the node manually, restart it with the new binary:

{% code overflow="wrap" %}
```sh
~/layer/binaries/v6.1.6/layerd start --home ~/.layer --key-name ACCOUNT_NAME --keyring-backend test --api.enable --api.swagger
```
{% endcode %}

If you run your node with systemd, update the `ExecStart` line in your `.service` file to point at the new binary. Use an absolute path instead of `~`:

{% code overflow="wrap" %}
```sh
ExecStart=/home/USERNAME/layer/binaries/v6.1.6/layerd start --home /home/USERNAME/.layer --keyring-backend="test" --key-name=ACCOUNT_NAME --api.enable --api.swagger
```
{% endcode %}

Then reload systemd and restart your service:

```sh
sudo systemctl daemon-reload
sudo systemctl restart layerd
sudo journalctl -u layerd -f
```

Replace `layerd` with the actual name of your service if it is different.

{% hint style="info" %}
Keep the old versioned binary directory until you are sure the node is running correctly after the upgrade. If you use cosmovisor, follow the cosmovisor upgrade flow instead of replacing `ExecStart` manually.
{% endhint %}
