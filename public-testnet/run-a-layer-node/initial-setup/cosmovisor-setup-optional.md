# Cosmovisor Setup (optional)

## Prerequisites:

* A Layer node machine configured like [this](../).

## Build and configure Cosmovisor

1. **Clone the cosmos repo, change directory to** `cosmos-sdk`

```sh
git clone https://github.com/cosmos/cosmos-sdk && cd cosmos-sdk/tools/cosmovisor
```

2. **Build cosmovisor with the command:**

```sh
go build ./cmd/cosmovisor
```

3. Add the following to the end of your `~/.bashrc` or `~/.zshrc` file:

```
# cosmovisor
export DAEMON_NAME=layerd
export DAEMON_HOME=$HOME/.layer
export DAEMON_RESTART_AFTER_UPGRADE=true
export DAEMON_ALLOW_DOWNLOAD_BINARIES=false
export DAEMON_POLL_INTERVAL=300ms
export UNSAFE_SKIP_BACKUP=true
export DAEMON_PREUPGRADE_MAX_RETRIES=0
```

Use  `source ~/.bashrc` or `source ~/.zshrc` to load the variables.

4. Gather binaries. You can clone the repo and create a build at each tag, or download them from the repo. For each release, select the binary that matches your OS / cpu architecture. (e.g. "Darwin\_arm64" for macOS,"Linux\_x86\_x64" for most cloud machines...)&#x20;

We will save them to a folder called binaries, but you can keep them anywhere you like. Download each binary to it's own folder:

{% code overflow="wrap" %}
```sh
# v0.2.1
mkdir ~/binaries && cd ~/binaries && mkdir v0.2.1 && cd v0.2.1 && wget https://github.com/tellor-io/layer/releases/download/v0.2.1/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz
# v0.3.0
cd ~/binaries && mkdir v0.3.0 && cd v0.3.0 && wget https://github.com/tellor-io/layer/releases/download/v0.3.0/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz
# v0.4.2...
...
```
{% endcode %}

To check that these downloaded and extracted correctly: `ls ~/binaries`

5. Once you have all of the binaries downloaded, initialize Cosmovisor and add all the upgrades. Change the file paths in the command to match the path to each binary exactly:

```shell
# set up cosmovisor. Each command is done seperatly.
./cosmovisor init ~/binaries/v0.2.1/layerd
./cosmovisor add-upgrade v0.3.0 ~/binaries/v0.3.0/layerd
# ...
```
