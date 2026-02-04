# Cross-Chain Token Bridge

This repository provides the smart contract foundation for a cross-chain bridge. It uses the **Lock & Mint** model, where tokens are locked on a source chain (e.g., Ethereum) to trigger the minting of a wrapped representation on a destination chain (e.g., Polygon).



## Features
* **Atomic Locking**: Securely holds user funds on the origin chain.
* **Wrapped Tokens**: Deployable ERC20 tokens on the destination chain that maintain a 1:1 peg.
* **Signature Verification**: Relayer-based system to ensure only authorized cross-chain messages trigger minting.

## Workflow
1. **Source**: User calls `lock()` on the `BridgeLocker` contract.
2. **Relayer**: An off-chain service detects the `Locked` event and signs a message.
3. **Destination**: User (or relayer) calls `mint()` on the `BridgeWrapped` contract with the valid signature.
4. **Reverse**: To go back, the wrapped token is burned, and the original asset is released.

## License
MIT
