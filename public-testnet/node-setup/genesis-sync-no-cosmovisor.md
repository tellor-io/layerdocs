---
description: Sync an archive node with the entire chain state.
---

# Genesis Sync (no cosmovisor)

{% hint style="info" %}
<mark style="color:blue;">Note:</mark> Steps may have multiple options. Be sure to choose the tab that matches your machine / desired setup.
{% endhint %}

_<mark style="color:green;">**Before starting your node**</mark><mark style="color:green;">,</mark> it's a good idea to think about how you want to run it so that the process does not get killed accidentally. This is not obvious for beginners._ [_GNU screen_](https://tellor.io/blog/how-to-manage-cli-applications-on-hosted-vms-with-screen/) _is a great option for beginners. More advanced setups can be achieved using systemd._

_**When syncing from genesis, simply start your layer node with the command:**_

```bash
./layerd start
```

You should now see your log quickly downloading blocks!

When syncing the chain from genesis, changing binaries at each upgrade height is required. The upgrades for the current layertest-2 chain are as follows:

## Applying Upgrade **`v2.0.0-audit`**&#x20;

**Let the node sync until it reaches height: "745000". Height can be checked by viewing the logs, or use the command:**

```sh
./layerd query block | grep -A 5 "app_hash"
```

_**Stop your layer node then checkout git commit #634c27667b504beead473321a964aab866866fe3 for building v2.0.0-audit:**_

```sh
git checkout main \
git pull \
git checkout 634c27667b504beead473321a964aab866866fe3 \
go build ./cmd/layerd
```

When the build finishes, start your node back up with `./layerd start`

## Applying Upgrade **`v2.0.1`**

**Let the node sync until it reaches height: "`931105`".**

_**Stop your layer node then checkout the tag v2.0.1-fix:**_

```bash
# upgrade to version v2.0.0-audit (hotfix commit)
git checkout main \
git pull \
git checkout v2.0.1-fix \
go build ./cmd/layerd
```

The start your layer process up again with `./layerd start`

The node can now fully sync.

## Finish Syncing

Check if you're fully synced. Open another terminal window and use the command:

```bash
./layerd status
```

You should see a json formated list of information about your running node. If you see `catching_up":false` that means that you're node is fully synced and ready to use!
