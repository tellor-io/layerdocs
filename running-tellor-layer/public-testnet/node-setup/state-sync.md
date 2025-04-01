---
description: Help with a few common setup problems. (more to be added in this section soon)
---

# Troubleshooting

### Just need to start over?

To uninstall different parts of layer and start over:

```sh
# Delete the binaries
# This is useful if you're not sure that you downloaded the right binaries:
rm -rf ~/layer/binaries

# deletes chain data
# This is useful if state sync fails and you need to try a different config
rm -rf ~/.layer/data/application.db; \
rm -rf ~/.layer/data/blockstore.db; \
rm -rf ~/.layer/data/cs.wal; \
rm -rf ~/.layer/data/evidence.db; \
rm -rf ~/.layer/data/snapshots; \
rm -rf ~/.layer/data/state.db; \
rm -rf ~/.layer/data/tx_index.db
```

