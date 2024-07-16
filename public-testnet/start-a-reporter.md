# Start a Reporter

Once you’re successfully running a validator, you’re almost a reporter already! Just one more command:

```sh
./layerd tx reporter create-reporter "100000000000000000" "1000000" --from $NODE_NAME --keyring-backend test --chain-id layer --home $LAYERD_NODE_HOME
```

Restart your node again, but this time we will change the command a bit to turn on the price daemon:

```sh
./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false
```

### Steps to unjail:

Layer testnet is still experimental, and jailing can happen for various reasons while we work out the kinks. Make sure your terminal window (shell) has all the variables loaded before trying to build txs. Read all steps first because you have about 4 minutes to do everything or you will be jailed again for inactivity:

1.  stop your node / validator / reporter with and start it back up as a node / validator (turning off the reporter):

    ```
    ./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false
    ```
2.  enter the unjail the command:

    ```
    ./layerd tx slashing unjail --from $NODE_NAME --chain-id layer --yes
    ```
3.  Restart the node with reporter daemon turned on:

    ```
    ./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false
    ```

#### [ ](https://sepolia.etherscan.io/address/0x7a261EAa9E8033B1337554df59bD462ca4A251FA#writeContract)
