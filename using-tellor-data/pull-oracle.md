---
description: A pull implementation for Tellor users
---

# Pull Oracle

## Using Tellor Pull on EVM: library, flow, and sample borrow app

Tellor Pull is for builders who need **oracle data inside the same transaction** as the user action—borrow, liquidate, resolve a market, and so on. Instead of relying on a stored on-chain value that someone else pushed earlier, you **pull** the latest attested report and proofs from Tellor Layer, attach them to the call, and your contract **verifies** via Tellor’s DataBridge and **uses** the value in one shot. That gives you fresher, user-driven reads without a separate “update oracle” step, and it maps cleanly to lending, stablecoins, and prediction markets where price or outcome must be atomic with the protocol logic.

This article combines the practical material from two places: the **using-tellor-pull** npm package from the [UsingTellorPull](https://github.com/tellor-io/UsingTellorPull) repository, and the [**SampleTellorUserPull**](https://github.com/tellor-io/SampleTellorUserPull) repo & reference app (React + Solidity borrow on Sepolia). Read it top-down for context, then use the sections as checklists for your own integration.

### Package contents

* **API** — Fetch and encoding helpers, plus explicit pull modes (consensus-first, consensus-only, optimistic-only). Build output lives in `dist/` when you consume the published package.

### End-to-end flow

* Your app uses the library to fetch attestation, validator set, and signatures from Tellor Layer and encode them for the EVM.
* If the DataBridge’s validator set is stale, you use `getValsetUpdatePayloads` to build `updateValidatorSet` transactions (skip relay) before oracle verification will succeed.
* You pass `attestData`, `validators`, and `sigs` into your contract (for example as ABI-encoded calldata).
* Your contract calls `dataBridge.verifyOracleData(...)` and uses the value in the same transaction.

**Assumption:** You deploy on an EVM chain where Tellor’s DataBridge is deployed.

### Install

```bash
npm install usingtellorpull ethers
```

### Quick start (fetch and encode)

Production integrations should bind the pull to the destination DataBridge before submitting calldata. Read `validatorTimestamp()`, `powerThreshold()`, and `lastValidatorSetCheckpoint()`, then use `getVerifiedPullPayload` (or a mode helper with `bridgeState`). `getPullPayload` remains a raw fetch helper for tests and inspection—it does not check destination bridge checkpoint or recovered signature power by itself.

```typescript
import {
  getVerifiedPullPayload,
  encodeBridgeCallArgsFromPayload,
  spotPriceQueryId,
  TELLOR_LAYER_API,
  type BridgeState,
} from "using-tellor-pull";

const queryIdHex = spotPriceQueryId("eth", "usd");
const bridgeState: BridgeState = {
  timestamp: (await dataBridge.validatorTimestamp()).toString(),
  powerThreshold: (await dataBridge.powerThreshold()).toString(),
  checkpoint: await dataBridge.lastValidatorSetCheckpoint(),
};
const payload = await getVerifiedPullPayload(queryIdHex, TELLOR_LAYER_API, bridgeState);
const { attestData, validators, sigs } = encodeBridgeCallArgsFromPayload(payload);
// Pass attestData, validators, sigs to your contract; it calls dataBridge.verifyOracleData(...)
```

#### Explicit pull modes

Use mode helpers when you want the library to enforce acceptance policy _before_ you submit calldata (recommended for production UX).

```typescript
import {
  getConsensusFirstPayload,
  getConsensusOnlyPayload,
  getOptimisticOnlyPayload,
  encodeBridgeCallArgsFromPayload,
  spotPriceQueryId,
  TELLOR_LAYER_API,
} from "using-tellor-pull";
import type { BridgeState } from "using-tellor-pull";

const queryId = spotPriceQueryId("eth", "usd");
const bridgeState: BridgeState = {
  timestamp: (await dataBridge.validatorTimestamp()).toString(),
  powerThreshold: (await dataBridge.powerThreshold()).toString(),
  checkpoint: await dataBridge.lastValidatorSetCheckpoint(),
};
const powerThreshold = Number(await dataBridge.powerThreshold());

const result = await getConsensusFirstPayload(queryId, TELLOR_LAYER_API, {
  bridgeState,
  filterOptions: { powerThreshold },
});

if (result.status !== "ok" || !result.payload) {
  console.log(result.status, result.reason, result.message);
  return;
}

const { attestData, validators, sigs } = encodeBridgeCallArgsFromPayload(result.payload);
```

**Mode behavior:**

* `getConsensusFirstPayload` — Matches SampleTellorUserPull semantics (consensus first, controlled optimistic fallback).
* `getConsensusOnlyPayload` — Requires consensus report plus freshness checks.
* `getOptimisticOnlyPayload` — Requires optimistic report plus freshness, dispute delay, and optimistic power gate.

All mode helpers return a structured `PullModeResult` with `status: "ok" | "unsatisfied" | "error"` and `reason` (for example `checkpoint_mismatch` or `insufficient_signature_power` when `bridgeState` is supplied).

#### Validator set skip relay

If the DataBridge’s on-chain validator set is behind Tellor Layer, attestations will fail verification until the bridge is updated. Use `getValsetUpdatePayloads` and submit `updateValidatorSet` in a loop until caught up:

```typescript
import { getValsetUpdatePayloads, TELLOR_LAYER_API } from "using-tellor-pull";
import type { BridgeState } from "using-tellor-pull";

const bridgeState: BridgeState = {
  timestamp: (await dataBridge.validatorTimestamp()).toString(),
  powerThreshold: (await dataBridge.powerThreshold()).toString(),
  checkpoint: await dataBridge.lastValidatorSetCheckpoint(),
};

while (true) {
  const payloads = await getValsetUpdatePayloads(bridgeState, TELLOR_LAYER_API);
  if (payloads.length === 0) break;
  for (const p of payloads) {
    const tx = await dataBridge.updateValidatorSet(
      p.newValsetHash, p.newPowerThreshold, p.newTimestamp,
      p.currentValidators, p.sigs
    );
    await tx.wait();
  }
  bridgeState.timestamp = (await dataBridge.validatorTimestamp()).toString();
  bridgeState.powerThreshold = (await dataBridge.powerThreshold()).toString();
  bridgeState.checkpoint = await dataBridge.lastValidatorSetCheckpoint();
}
```

### Solidity

Your contract verifies attestations via Tellor’s DataBridge. Use the DataBridge interface (structs and `verifyOracleData`) from Tellor’s DataBridge repository. Off-chain production flow: `getVerifiedPullPayload` or a mode helper with `bridgeState` → `encodeBridgeCallArgsFromPayload` → pass `attestData`, `validators`, `sigs`. The sample repo below shows a full consumer contract.

### API (npm package)

| Function                                                               | Description                                                                                                                                                                 |
| ---------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `getReport(queryIdHex, apiBase, options?)`                             | Current aggregate value and timestamp for the query ID.                                                                                                                     |
| `getAttestationBundle(queryIdHex, reportTimestamp, apiBase, options?)` | Validator set and signatures for that report.                                                                                                                               |
| `getPullPayload(queryIdHex, apiBase, options?)`                        | Raw report plus attestation assembly. With `reportTimestampMs`, skips current aggregate and loads that report time from Layer. Does not check destination DataBridge state. |
| `getVerifiedPullPayload(queryIdHex, apiBase, bridgeState, options?)`   | Production helper: raw payload plus destination DataBridge checkpoint and recovered signature power checks.                                                                 |
| `getConsensusFirstPayload(queryIdHex, apiBase, options?)`              | Consensus-first with controlled optimistic fallback (sample-compatible defaults).                                                                                           |
| `getConsensusOnlyPayload(queryIdHex, apiBase, options?)`               | Consensus-only with freshness checks.                                                                                                                                       |
| `getOptimisticOnlyPayload(queryIdHex, apiBase, options?)`              | Optimistic-only with freshness, delay, and power checks.                                                                                                                    |
| `encodeBridgeCallArgs(attestation)`                                    | Returns `{ attestData, validators, sigs }` for the bridge.                                                                                                                  |
| `encodeBridgeCallArgsFromPayload(payload)`                             | Same encoding from a pull payload.                                                                                                                                          |
| `spotPriceQueryId(asset, currency)`                                    | Query ID for SpotPrice (for example `"btc"`, `"usd"`).                                                                                                                      |
| `spotPriceQueryIdBytes32(asset, currency)`                             | Same as bytes32 (0x-prefixed) for Solidity.                                                                                                                                 |
| `generateWithdrawalQueryId(withdrawalId)`                              | TRBBridge withdrawal (Layer → Ethereum).                                                                                                                                    |
| `generateDepositQueryId(depositId)`                                    | TRBBridge deposit (Ethereum → Layer).                                                                                                                                       |
| `queryIdFromData(queryData)`                                           | Generic: `keccak256(queryData)`.                                                                                                                                            |
| `getValsetUpdatePayloads(bridgeState, apiBase, options?)`              | Skip relay: build `updateValidatorSet` payloads to bring the DataBridge current.                                                                                            |

Types include `BridgeState`, `ValsetUpdatePayload`, `PullPayload`, `PullModeResult`, `PullModeOptions`, `VerifiedPullPayloadOptions`, `AttestationBundle`, `BridgeCallArgsEncodable`, and others.

Constants include `TELLOR_LAYER_API` (for example `https://mainnet.tellorlayer.com`), `LAYER_MAINNET_API`, and `LAYER_TESTNET_API`.

#### Fetch options and `reportTimestampMs`

Optional last parameter for `getReport`, `getPullPayload`, `getAttestationBundle`: `{ timeoutMs?: number, maxRetries?: number, reportTimestampMs?: number }`. Defaults are typically a 30s timeout and retries on 5xx or network errors.

When `reportTimestampMs` is set on `getPullPayload` (or in `PullModeOptions` for mode helpers), the client does **not** call the current aggregate endpoint; it loads the attestation bundle for that report time. Use this with a real `apiBase` after you discover a report timestamp (for example via `npm run discover-report`) so optimistic-only rules can run against Layer-backed signatures.

#### Mode helper options (`PullModeOptions`)

Fetch options (including optional `reportTimestampMs`), optional `bridgeState`, plus `filterOptions`:

* `nowSec` (optional test override)
* `maxDataAgeSec` (default 24h)
* `maxAttestationAgeSec` (default 10m)
* `optimisticDelaySec` (default 12h)
* `powerThreshold` (required for optimistic checks)
* `requiredSignaturePower` (optional; defaults to `bridgeState.powerThreshold` when `bridgeState` is supplied)

When `bridgeState` is supplied, mode helpers reject `status: "ok"` if the attestation checkpoint does not match the destination DataBridge checkpoint or recovered signature power is below the configured threshold.

#### Optimistic-only example

```typescript
import {
  getOptimisticOnlyPayload,
  encodeBridgeCallArgsFromPayload,
  spotPriceQueryId,
  TELLOR_LAYER_API,
} from "using-tellor-pull";
import type { BridgeState } from "using-tellor-pull";

const queryId = spotPriceQueryId("eth", "usd");
const reportTimestampMs = 1730000000000;
const bridgeState: BridgeState = {
  timestamp: (await dataBridge.validatorTimestamp()).toString(),
  powerThreshold: (await dataBridge.powerThreshold()).toString(),
  checkpoint: await dataBridge.lastValidatorSetCheckpoint(),
};
const powerThreshold = Number(await dataBridge.powerThreshold());

const result = await getOptimisticOnlyPayload(queryId, TELLOR_LAYER_API, {
  bridgeState,
  reportTimestampMs,
  filterOptions: { powerThreshold },
});

if (result.status !== "ok" || !result.payload) {
  console.log(result.status, result.reason, result.message);
  return;
}

const { attestData, validators, sigs } = encodeBridgeCallArgsFromPayload(result.payload);
```

**Optional Sepolia fork:** Point Anvil or Hardhat at Sepolia, use Layer API with `discover-report` / `getOptimisticOnlyPayload` and `reportTimestampMs`, then submit encoded args to your contract. Environment-specific; not part of default CI.

***

### Sample application: Borrow TRB (Tellor Pull)

The [SampleTellorUserPull](https://github.com/tellor-io/SampleTellorUserPull) repo demonstrates one use case: **borrow TRB** against **Sepolia ETH** collateral, then **repay TRB** to reclaim collateral. The frontend pulls **ETH/USD** and **TRB/USD** using `getConsensusFirstPayload(...)`, updates the DataBridge validator set when needed (skip relay, multiple hops capped in the UI), and passes attestations into `borrow`. The contract verifies through Tellor’s DataBridge and applies an **80% LTV**.

#### How it looks

* Connect wallet (Sepolia).
* Enter collateral (ETH) and borrow amount (TRB).
* **Borrow** — Check bridge validator set → pull oracle data → encode for EVM → `borrow(amount, ethAttest, trbAttest, validators, ethSigs, trbSigs)`.
* **Repay** — Approve TRB spend → `repay(amount)` → collateral returned proportionally (partial or full repay).

#### Sample flow: Borrow

1. User clicks Borrow in the frontend.
2. Frontend reads the DataBridge’s `validatorTimestamp()`, `powerThreshold()`, and `lastValidatorSetCheckpoint()`, then loops (up to 10 hops): fetch skip-relay payloads via `getValsetUpdatePayloads` and submit `dataBridge.updateValidatorSet(...)` until caught up.
3. After sync, frontend builds `bridgeState` from the bridge and requests ETH/USD and TRB/USD via `getConsensusFirstPayload(queryId, TELLOR_LAYER_API, { bridgeState, filterOptions: { powerThreshold } })`, then `encodeBridgeCallArgsFromPayload(payload)` for each feed (with retries if signatures cannot be recovered).
4. Frontend sends: `contract.borrow(amountTrbWei, ethAttestData, trbAttestData, validators, ethSigs, trbSigs, { value: collateralWei })`.
5. Contract verifies both attestations via `dataBridge.verifyOracleData(...)`, decodes prices, checks LTV, updates position, and transfers TRB.

#### Sample flow: Repay

1. User enters repay amount and confirms Repay.
2. Frontend approves the borrow contract to spend TRB if allowance is insufficient.
3. Frontend sends `contract.repay(amountTrbWei)`.
4. Contract returns ETH collateral proportionally.

#### Validator set skip relay in the sample

The frontend is responsible for keeping the DataBridge validator set current. If the bridge lags multiple rotations, skip relay:

1. Read the bridge’s trusted state (timestamp, power threshold, checkpoint).
2. Try to jump directly to the latest validator set.
3. If not enough signing power from the bridge’s current trusted set, walk backward to the furthest reachable target.
4. Repeat until caught up (the sample caps hops, for example 10).

The sample imports pull and relay helpers through `frontend/src/tellorPull.js`, which re-exports `using-tellor-pull` and sets `TELLOR_LAYER_API` (Vite dev proxy vs production URL). Implementation lives in [UsingTellorPull](https://github.com/tellor-io/UsingTellorPull) (`src/valsetRelay.ts`, `src/attestation.ts`).

#### Sample repo layout

```
SampleTellorUserPull/
├── README.md
├── docs/
│   └── borrow-ui.png
├── hardhat/
│   ├── contracts/
│   │   ├── BorrowWithTellorPull.sol
│   │   ├── interfaces/ITellorDataBridge.sol
│   │   └── testing/
│   ├── scripts/deploy.js
│   ├── test/BorrowWithTellorPull.test.js
│   ├── hardhat.config.js
│   ├── .env
│   └── package.json
└── frontend/
    ├── src/
    │   ├── App.jsx
    │   ├── tellorPull.js
    │   ├── contracts/
    │   └── index.css
    ├── vite.config.js
    ├── .env
    └── package.json
```

### Run the sample

#### 1. Contracts (Sepolia or local)

```bash
cd hardhat
npm install
npx hardhat test
```

Deploy to Sepolia (set `hardhat/.env`: `SEPOLIA_PRIVATE_KEY`, `SEPOLIA_RPC_URL`, `ETHERSCAN_API_KEY`, optional `TRB_ADDRESS`):

```bash
npx hardhat run scripts/deploy.js --network sepolia
```

The script deploys, waits for confirmations, and can auto-verify on Etherscan. Fund the borrow contract with TRB after deploy so it can lend (approve + `fundTrb` from the deployer wallet).

#### 2. Frontend

```bash
cd frontend
npm install
```

Set `frontend/.env`:

```
VITE_BORROW_CONTRACT_ADDRESS=<deployed borrow contract>
VITE_TRB_ADDRESS=<TRB token address>
VITE_TELLOR_LAYER_API=<tellor layer REST API base URL>
VITE_SEPOLIA_RPC_URL=https://1rpc.io/sepolia
```

```bash
npm run dev
```

Open the dev URL, connect on Sepolia, and exercise borrow and repay. Local dev often uses a Vite proxy so browser calls avoid CORS; production builds use `VITE_TELLOR_LAYER_API` directly.

### Testing the library (developers)

```bash
npm install
npm test
npm run test:smoke
npm run live:modes
npm run discover-report -- <queryIdHex> <reportTimestampMs>
```

Hardhat tests in the sample include optimistic-shaped oracle data so on-chain filter rules are covered without Live Layer or a fork in the default test run.

### Secure integrations

For production security guidance, use the [Tellor documentation](https://docs.tellor.io) and review how your protocol uses decoded values (liquidations, LTV, resolution rules). The DataBridge’s `VALIDATOR_SET_HASH_DOMAIN_SEPARATOR` is chain-specific (`keccak256(abi.encode("checkpoint", CHAIN_ID))`). Skip relay behavior is implemented in `using-tellor-pull` (`src/valsetRelay.ts` in [UsingTellorPull](https://github.com/tellor-io/UsingTellorPull)); relay builders validate the bridge’s on-chain checkpoint and power threshold against Tellor Layer before proposing hops.

### Repositories and links

* **Library:** [tellor-io/UsingTellorPull](https://github.com/tellor-io/UsingTellorPull) (npm **using-tellor-pull**)
* **Sample:** [tellor-io/SampleTellorUserPull](https://github.com/tellor-io/SampleTellorUserPull)
* **Related structure:** [sample-tellor-layer-pull](https://github.com/tellor-io/sample-tellor-layer-pull)

_Maintainers and community: see the GitHub repos for issues; Tellor_ [_Discord_](https://discord.gg/teAMSZAfJZ) _for contributions. Tellor Inc._
