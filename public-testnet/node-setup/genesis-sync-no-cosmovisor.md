---
description: Sync an archive node with the entire chain state.
---

# Genesis Sync (no cosmovisor)

_<mark style="color:green;">**Before starting your node**</mark><mark style="color:green;">,</mark> it's a good idea to think about how you want to run it so that the process does not get killed accidentally. This is not obvious for beginners._ [_GNU screen_](https://tellor.io/blog/how-to-manage-cli-applications-on-hosted-vms-with-screen/) _is a great option for beginners. More advanced setups can be achieved using systemd._

_**When syncing from genesis, simply start your layer node with the command:**_

```bash
./layerd start
```

You should now see your log quickly downloading blocks!

## Finish Syncing

To check if you're fully synced. Open another terminal window and use the command:

```bash
./layerd status
```

You should see a json formated list of information about your running node. If you see `catching_up":false` that means that you're node is fully synced and ready to use!
