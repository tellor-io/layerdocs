# State Sync Setup (optional)

_Tip: If you have already started syncing and you want to start over with a state sync, you will need to delete all of the .db folders and the snapshots folder from \~/.layer/data folder:_

```sh
# deletes chain data for resyncing
rm -rf ~/.layer/data/application.db; \
rm -rf ~/.layer/data/blockstore.db; \
rm -rf ~/.layer/data/cs.wal; \
rm -rf ~/.layer/data/evidence.db; \
rm -rf ~/.layer/data/snapshots
rm -rf ~/.layer/data/state.db
rm -rf ~/.layer/data/tx_index.db
```

1. **Find a good trusted height:**\
   _Note: The trusted height in production should be set to 21 days before current block to make sure all validators are honest. However, at the time of writing the chain is not yet 21 days old! We will instead use one hour._

Use the command:

```sh
export LATEST_HEIGHT=$(curl -s tellorlayer.com:26657/block | jq -r .result.block.header.height); \
export TRUSTED_HEIGHT=$((LATEST_HEIGHT-2000)); \ # current block - 1 hour
export TRUSTED_HASH=$(curl -s "tellorlayer.com:26657/block?height=$TRUSTED_HEIGHT" | jq -r .result.block_id.hash); \
echo $TRUSTED_HEIGHT $TRUSTED_HASH
```

This should output something like: `138807 0BCE40CD31D205453DA001780CBF765F3C64FCCB9DCB2F9825872D042780A288.`

Copy this block and hash and keep it handy for the next step.

2. **Edit config.toml:**

Open your config file with your favorite text editor or nano:

```sh
nano ~/.layer/config/config.toml
```

Scroll or search the document and edit the variables as shown here:

```toml
# [p2p]
seed_mode = true

# [statesync]
enable = true
#...
rpc_servers = "http://tellorlayer.com:26657,http://tellorlayer.com:26657"
trust_height = 137949
trust_hash = "F23E2ACAFF92FFEDE14CC9949A60F50E7C6D5A2D40BC9C838DF523944063294D"
trust_period = "168h0m0s"
```

Be sure to replace the trust\_height and trust\_hash with the block number and hash from step 1.

Exit nano with `ctrl^x` then enter `y` to save the changes.

3. Upgrade your binary to the current version:

{% code overflow="wrap" %}
```bash
# use binary v1.6.0
git checkout main && git pull && git checkout v1.6.0 && go build ./cmd/layerd
```
{% endcode %}

3. Start your node:

```
./layerd start
```
