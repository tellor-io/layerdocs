# Cosmovisor Setup (optional)

## Prerequisites:

* A Layer node machine configured like [this](./).

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

We will save them to a folder called binaries, but you can keep them anywhere you like. Download each binary to it's own folder. (**This command is just an example, so be sure that you know which binaries to get before you start! If you're not sure, ask in our discord)**:

{% code overflow="wrap" %}
```sh
# genesis version v2.0.0-alpha1
mkdir ~/binaries && cd ~/binaries && mkdir v2.0.0-alpha1 && cd v2.0.0-alpha1 && wget https://github.com/tellor-io/layer/releases/download/v0.2.1/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz

# commit hash 634c27667b504beead473321a964aab866866fe3
cd ~/binaries \
mkdir 634c27667b504beead473321a964aab866866fe3 \
cd 634c27667b504beead473321a964aab866866fe3 \
git clone https://github.com/tellor-io/layer \
git checkout 634c27667b504beead473321a964aab866866fe3 \
go build ./cmd/layerd \
mv layerd ~/binaries/634c27667b504beead473321a964aab866866fe3/layerd

# v2.0.1-fix
cd ~/binaries && mkdir v2.0.1-fix && cd v2.0.1-fix && wget https://github.com/tellor-io/layer/releases/download/v2.0.1-fix/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz
...
```
{% endcode %}

To check that these downloaded and extracted correctly: `ls ~/binaries`

5. Once you have all of the binaries downloaded, initialize Cosmovisor and add all the upgrades. Change the file paths in the command to match the path to each binary exactly:

```shell
# set up cosmovisor. Each command is done seperatly.
./cosmovisor init ~/binaries/v2.0.0-alpha1/layerd
./cosmovisor add-upgrade v0.3.0 ~/binaries/634c27667b504beead473321a964aab866866fe3/layerd
./cosmovisor add-upgrade v0.3.0 ~/binaries/v2.0.1-fix/layerd
# ...
```

6. To start your node with cosmovisor managing upgrades:

{% code overflow="wrap" %}
```sh
cosmovisor run start --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false --key-name $ACCOUNT_NAME
```
{% endcode %}
