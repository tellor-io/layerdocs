# Getting Testnet TRB

**Validators are required to stake.**  You will need to have some layer testnet TRB into your validator account (see step 7 in Running a node). Feel free to send a request with your tellor address in the public [discord](https://discord.gg/tellor) #testing-layer channel, or try the token bridge from the Sepolia testnet playground:

### 1. Mint Testnet TRB

You can mint Layer Testnet TRB using this [Sepolia Tellor Playground](https://sepolia.etherscan.io/address/0xceBa0609797251395CFB420a1540E58b6be0828d#writeContract) contract’s “faucet” command. Connect your wallet, click the function `5. faucet`, put your sepolia ethereum address in the \_user field, click write and confirm your transaction.\


<figure><img src="../.gitbook/assets/Screenshot 2024-08-13 at 11.36.39 AM.png" alt=""><figcaption><p>Click "Write" and confirm the transaction in your wallet.</p></figcaption></figure>

You should now have 1000 TRBP in your sepolia wallet for bridging to layer.

_Note: TRBP (contract address `0xceBa0609797251395CFB420a1540E58b6be0828d`) is different from the sepolia TRB token used for reporting to sepolia tellor._

### 2. Approve the bridge contract

Click on function `2. approve`. \
Set spender to the bridge contract address: `0x1AaF421491171930e71fb032B765DF252CE3F97e` Set \_amount to: `1000000000000000000000`

<figure><img src="../.gitbook/assets/Screenshot 2024-08-13 at 9.17.43 AM.png" alt=""><figcaption><p>Click "Write" and confirm the transaction in your wallet.</p></figcaption></figure>

### 3. Make the bridge request (depositToLayer)

Once you have TRBP in your wallet, head over to the [Layer Testnet bridge](https://sepolia.etherscan.io/address/0x1AaF421491171930e71fb032B765DF252CE3F97e#writeContract). Connect your wallet and click function `3. depositToLayer`. \
Set the amount to the amount of TRBP that you want to bridge, e.g. 100000000000000000000 (100 TRBP + 18 decimals).\
Set \_layerRecipient to your tellor prefix address on layer. If you don't have an address yet, see steps to Create an account on Layer [here](run-a-layer-node/).

<figure><img src="../.gitbook/assets/Screenshot 2024-08-13 at 11.47.26 AM.png" alt=""><figcaption><p>Click "Write" and confirm the transaction in your wallet.</p></figcaption></figure>

Open your transaction via block explorer and retrieve the `depositId` from the event logs:

<figure><img src="../.gitbook/assets/Screenshot 2024-08-13 at 12.21.29 PM.png" alt=""><figcaption><p>Click the Logs tab</p></figcaption></figure>

<figure><img src="../.gitbook/assets/Screenshot 2024-08-13 at 12.21.15 PM.png" alt=""><figcaption><p>Scroll down until you see these lines. Copy all this information for later.</p></figcaption></figure>

### 4. Wait 12 hours

There's a 12 hour delay to secure deposits from sepolia to the layer testnet. While you wait it's a great opportunity to follow us on twitter or join the [tellor discord ](https://discord.gg/tellor)and say hello!

### 5. Claim the Tokens on Layer

Open a new terminal on your layer node machine and use the command (replacing `3` with your actual `depositId`):

{% code overflow="wrap" %}
```sh
./layerd tx bridge claim-deposit $ACCOUNT_NAME 3 0 --chain-id layertest-1 --keyring-backend $KEYRING_BACKEND --home $LAYERD_NODE_HOME --keyring-dir $LAYERD_NODE_HOME --fees 1000loya
```
{% endcode %}

You should see your new balance when you run the command:

```sh
./layerd query bank balance $TELLOR_ADDRESS loya --chain-id layertest-1
```

<figure><img src="../.gitbook/assets/Screenshot 2024-08-13 at 12.27.20 PM.png" alt=""><figcaption></figcaption></figure>
