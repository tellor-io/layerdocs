---
description: Safely integrate tellor oracle data into your contracts
icon: ethereum
---

# Integrating Tellor Data

Integrating tellor data into a user contract involves two major aspects:

* Verifying that the data is authentic tellor data
* Custom data checks unique to your use case and data needs

{% hint style="info" %}
See the [SampleLayerUser repo](https://github.com/tellor-io/SampleLayerUser) for a few example oracle use case implementations.
{% endhint %}

### Contract Addresses

TellorDataBridge Sepolia: [0xC69f43741D379cE93bdaAC9b5135EA3e697df1F8](https://sepolia.etherscan.io/address/0xC69f43741D379cE93bdaAC9b5135EA3e697df1F8)

### Verifying Data Authenticity

Tellor uses validator attestations to verify that data came from tellor. If at least 2/3 of tellor validators (by stake power) signed some data, we consider that to be authentic tellor data. The TellorDataBridge contract is responsible for verifying data authenticity. It does this by keeping track of the tellor validator set and verifying that at least 2/3 of tellor validators signed the data. As a user contract, you only need to pass the attestation data, validator set, and signature info to the TellorDataBridge contract for this authentication step.&#x20;

We will install the usingtellorlayer npm package to gain access to the TellorDataBridge interface:

```bash
npm i usingtellorlayer
```

The code block below shows how you can connect your contract to TellorDataBridge and pass tellor data to it to verify its authenticity.

```solidity
import "usingtellorlayer/contracts/interfaces/ITellorDataBridge.sol";

contract SamplePredictionMarketUser {
	ITellorDataBridge public bridge;
	
	constructor(address _bridge) {
		bridge = ITellorDataBridge(_bridge);
	}

	function updateOracleData(
        	OracleAttestationData calldata _attestData, 
        	Validator[] calldata _currentValidatorSet, 
        	Signature[] calldata _sigs
    	) public {
		// **************************************************
		// * AUTHENTICITY: verify that data came from tellor chain
		// **************************************************
		bridge.verifyOracleData(_attestData, _currentValidatorSet, _sigs);

		// … 
	}
}
```

Once your contract has verified that the inputted data is authentic tellor data, you should continue to performing custom checks based on your unique use case.

### Custom Checks

Custom checks will vary based on the use case and any other unique data needs. In this example contract, we show some checks used by an example prediction market.

#### Example Case

1. Verify that relayed data is the data we expect by checking the `queryId`.
   * For this example, we created a custom data type `PredictionMarketExample` which uses `marketId` and `chainId` arguments to create a unique identifier for each market
2. As a sanity check, make sure the data was reported after the market expiration time.
   * If your market allows resolution anytime after the market was created, use the market's start time instead of expiration time here.
3. Verify that `aggregatePower` meets some threshold. This is the amount of reporter stake power that was used to create the oracle data.
   * We used the `powerThreshold` from the TellorDataBridge contract as our threshold in the example below. This is equal to 2/3 of the total tellor stake amount.
   * In the event that the power does not reach the higher threshold, we check that the data both reaches the lower threshold, and has been on chain for a period of time to allow for disputes.

```solidity
	function updateOracleData(
        		OracleAttestationData calldata _attestData, 
        		Validator[] calldata _currentValidatorSet, 
        		Signature[] calldata _sigs, 
        		uint256 _marketId // id created for this use case
        ) public {
                // ...

		// **************************************************
		// * USER CHECKS: verify that the data is correct for this unique use case
		// **************************************************
		// verify that this data is for the correct marketId
		bytes32 _queryId = _getQueryId(_marketId);
		require(_queryId == _attestData.queryId);

                // verify that the attestations are not too old
                require(block.timestamp - (_attestData.attestationTimestamp / 1000) < 10 minutes);

		// verify that data was created after market expiration time
		require(_attestData.report.timestamp / 1000 > markets[_marketId].expiration);

		// verify data reporter power meets threshold (2/3 total power) or optimistic period
		if (_attestData.report.aggregatePower < bridge.powerThreshold()) {
				// make sure optimistic data meets lower threshold (1/3 total power)
				require(_attestData.report.aggregatePower > bridge.powerThreshold() / 2);
				// make sure data stayed on chain for at least 12 hours without being disputed
				require(_attestData.attestationTimestamp - _attestData.report.timestamp > (12 hours * 1000));
		}

		// ...
	}

	function _getQueryId(uint256 _marketId) private pure returns(bytes32) {
		bytes memory _queryDataArgs = abi.encode(chainId, _marketId);
		bytes memory _queryData = abi.encode(“PredictionMarketExample”, _queryDataArgs);
		bytes32 _queryId = keccak256(_queryData);
		return _queryId;
	}
```

### Use the Data

Once the data has passed the authenticity and custom user checks, you can decode and use the data. In this example, we defined a data type `PredictionMarketExample` which returns a `uint` 1-3 denoting a result of "Yes", "No", or "Invalid", respectively. Since all tellor data is reported in bytes, we decode the bytes to a uint, perform a few more sanity checks, and finally save the relayed oracle data in the contract.

```solidity
pragma solidity 0.8.19;

import "usingtellorlayer/contracts/interfaces/ITellorDataBridge.sol";

contract SamplePredictionMarketUser {
	ITellorDataBridge public bridge;
	MarketInfo[] public markets;
	uint256 public chainId = block.chainid;

	struct MarketInfo {
		string details;
		uint256 result; // 0-unresolved, 1-yes, 2-no, 3-invalid 
		uint256 expiration;
	}
	
	constructor(address _bridge) {
		bridge = ITellorDataBridge(_bridge);
	}

	function updateOracleData(
        	OracleAttestationData calldata _attestData, 
        	Validator[] calldata _currentValidatorSet, 
        	Signature[] calldata _sigs, 
        	uint256 _marketId
        ) public {
		// **************************************************
		// * AUTHENTICITY: verify that data came from tellor chain
		// **************************************************
		bridge.verifyOracleData(_attestData, _currentValidatorSet, _sigs);

		// **************************************************
		// * CUSTOM USER CHECKS: verify that the data is correct for this unique use case
		// **************************************************
		// verify that this data is for the correct marketId
		bytes32 _queryId = _getQueryId(_marketId);
		require(_queryId == _attestData.queryId);

        	// verify that the attestations are not too old
        	require(block.timestamp - (_attestData.attestationTimestamp / 1000) < 10 minutes);

		// verify that data was created after market expiration time
		require(_attestData.report.timestamp / 1000 > markets[_marketId].expiration);

        	// verify data reporter power meets threshold (2/3 total power) or optimistic period
        	if (_attestData.report.aggregatePower < bridge.powerThreshold()) {
            		// make sure optimistic data meets lower threshold (1/3 total power)
            		require(_attestData.report.aggregatePower > bridge.powerThreshold() / 2);
            		// make sure data stayed on chain for at least 12 hours without being disputed
            		require(_attestData.attestationTimestamp - _attestData.report.timestamp > (12 hours * 1000));
        	}

		// **************************************************
		// * USE THE DATA: resolve the market
		// **************************************************
		uint256 _result = abi.decode(_attestData.report.value, (uint256));
		_resolveMarket(_marketId, _result);
	}

	function _getQueryId(uint256 _marketId) internal view returns(bytes32) {
		bytes memory _queryDataArgs = abi.encode(chainId, _marketId);
		bytes memory _queryData = abi.encode("PredictionMarketExample", _queryDataArgs);
		bytes32 _queryId = keccak256(_queryData);
        	return _queryId;
	}

	function _resolveMarket(uint256 _marketId, uint256 _result) private {
		// make sure market is expired
		MarketInfo storage _market = markets[_marketId];
		require(block.timestamp > _market.expiration);

		// make sure market has not already been resolved
		require(_market.result == 0);

		// make sure the data conforms to the expected range (1, 2, or 3)
		require(_result > 0 && _result <= 3);
		
		// finally, save result
		_market.result = _result;
	}
}
```

### Available Metadata

Below is all of the data and metadata available to a user contract. We encourage users to find ways to use it to protect the integrity of their oracle data.

* **QueryId** - The unique identifier for each data type.
* **Aggregate Value** - This is the aggregated oracle data from all reporters who submitted.
* **Report Timestamp** - This is the timestamp of the block when the report was aggregated
* **Aggregate Power** - This is the total stake power of all reporters who reported to create this aggregate data.
* **Previous Timestamp** - This is the timestamp of the last aggregate report before this one.
* **Next Timestamp** - This is the timestamp of the next report aggregated after this one.
* **Last Validator Set Checkpoint** - This is a hash of the current validator set and some extra metadata.
* **Attestation Timestamp** - This is the time of when the attestation was created
* **Last Consensus Timestamp** - This is the timestamp of the last aggregate which had at least 2/3 of reporter power
* **Power Threshold** - This is equal to 2/3 of the total tokens tellor validators have at stake
