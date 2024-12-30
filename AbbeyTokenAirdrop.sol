// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract RandomWalletAirdrop {
    address public owner;
    IERC20 public abbeyToken;

    // Events of
    event AirdropExecuted(address[] recipients, uint256[] amounts);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can execute this action");
        _;
    }

    constructor(address _abbeyTokenAddress) {
        owner = msg.sender;
        abbeyToken = IERC20(_abbeyTokenAddress);
    }

    // Declare memory arrays for recipients and token amounts
    uint256 public tokenDecimal = 18; // 18 decimals for your token
    uint256 public batchSize = 1000;  // Number of wallets per batch

    /// @notice Execute an airdrop for a specified batch of wallets (up to 1000 wallets per call)
    function executeAirdropBatch() external onlyOwner {
        uint256 totalAmountRequired = 0;

        // Pre-allocate memory arrays for recipients and token amounts
        address[] memory tempRecipients = new address[](batchSize);
        uint256[] memory tempTokenAmounts = new uint256[](batchSize);

        // Calculate total tokens required before transfers
        for (uint256 i = 0; i < batchSize; i++) {
            uint256 randomAmount = random(100 * 10**tokenDecimal, 1000 * 10**tokenDecimal); // Scale the random amount for 18 decimals
            totalAmountRequired += randomAmount;

            // Assign values to the memory arrays
            tempRecipients[i] = computeRandomAddress(i);
            tempTokenAmounts[i] = randomAmount;
        }

        // Check if the contract has enough tokens for the airdrop
        require(abbeyToken.balanceOf(address(this)) >= totalAmountRequired, "Insufficient token balance for airdrop");

        // Transfer tokens to each random address
        for (uint256 i = 0; i < batchSize; i++) {
            require(abbeyToken.transfer(tempRecipients[i], tempTokenAmounts[i]), "Token transfer failed");
        }

        // Emit the AirdropExecuted event for this batch
        emit AirdropExecuted(tempRecipients, tempTokenAmounts);
    }

    /// @notice Compute a random Ethereum address
    /// @param index An index to create uniqueness in each computed address
    /// @return Randomly computed Ethereum address
    function computeRandomAddress(uint256 index) internal view returns (address) {
        return address(uint160(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, index)))));
    }

    /// @notice Generates a pseudo-random number between min and max
    /// @param min Minimum value
    /// @param max Maximum value
    /// @return Random number
    function random(uint256 min, uint256 max) internal view returns (uint256) {
        return min + uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) % (max - min + 1);
    }

    /// @notice Withdraw remaining ABBEY tokens from the contract
    function withdrawTokens() external onlyOwner {
        uint256 balance = abbeyToken.balanceOf(address(this));
        require(balance > 0, "No tokens to withdraw");
        abbeyToken.transfer(owner, balance);
    }

    /// @notice Change the owner of the contract
    /// @param newOwner New owner's address
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid new owner address");
        owner = newOwner;
    }
}
