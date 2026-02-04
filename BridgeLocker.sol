// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title BridgeLocker
 * @dev Contract on the source chain where tokens are locked.
 */
contract BridgeLocker is Ownable {
    IERC20 public token;

    event Locked(address indexed user, uint256 amount, uint256 nonce);
    event Released(address indexed user, uint256 amount);

    constructor(address _token) Ownable(msg.sender) {
        token = IERC20(_token);
    }

    /**
     * @notice Locks tokens to be moved to another chain.
     */
    function lock(uint256 amount, uint256 nonce) external {
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        emit Locked(msg.sender, amount, nonce);
    }

    /**
     * @notice Releases tokens when moving back from the destination chain.
     * Only callable by the bridge owner/relayer after verifying burn on the other side.
     */
    function release(address user, uint256 amount) external onlyOwner {
        require(token.transfer(user, amount), "Transfer failed");
        emit Released(user, amount);
    }
}
