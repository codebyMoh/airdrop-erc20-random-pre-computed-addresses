
# Abbey Token Airdrop Contract

## Overview
The Abbey Token Airdrop Contract is a Solidity-based smart contract designed to efficiently distribute Abbey Tokens (ERC-20) to pre-computed or random addresses. This contract ensures secure and verifiable token airdrops for promotional events or token distribution campaigns.

---

## Features
- **Random Pre-Computed Address Distribution**: Allows distributing tokens to a set of pre-computed random addresses.
- **Efficient Batch Transfers**: Supports batch transfers to minimize gas fees.
- **Secure Access Control**: Admin-only functions to initiate the airdrop and manage contract parameters.
- **Customizable Airdrop Amounts**: Flexibility to define the amount of tokens distributed per address.

---

## Prerequisites
### Tools & Technologies
1. **Solidity**: Version 0.8.0 or above.
2. **Node.js and NPM**: For running scripts and managing dependencies.
3. **Hardhat or Truffle**: For contract deployment and testing.
4. **MetaMask or Web3 Wallet**: For interacting with the contract on a blockchain network.

### Blockchain Networks
- The contract is compatible with Ethereum and EVM-compatible chains (e.g., Polygon, Binance Smart Chain).

---

## Installation & Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/<your-github-username>/airdrop-erc-20-random-pre-computed-addresss.git
   cd airdrop-erc-20-random-pre-computed-addresss
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Compile the contract:
   ```bash
   npx hardhat compile
   ```

---

## Usage

### Deploying the Contract
1. Configure the deployment script:
   Update the deployment script with your network settings and token contract address.
   ```javascript
   const AbbeyTokenAirdrop = artifacts.require("AbbeyTokenAirdrop");
   ```
2. Deploy:
   ```bash
   npx hardhat run scripts/deploy.js --network <network_name>
   ```

### Running the Airdrop
1. **Set the Recipient Addresses**:
   Call the `addRecipients` function with an array of recipient addresses.
   ```solidity
   function addRecipients(address[] memory recipients) public onlyOwner;
   ```

2. **Distribute Tokens**:
   Trigger the `distributeTokens` function to execute the airdrop.
   ```solidity
   function distributeTokens(uint256 amountPerRecipient) public onlyOwner;
   ```

---

## Testing
1. Run unit tests:
   ```bash
   npx hardhat test
   ```
2. View test results for gas consumption and correctness.

---

## Security Considerations
- Ensure the admin wallet is securely managed to prevent unauthorized access.
- Use a multisig wallet for high-value token airdrops.
- Audit the contract before deploying to the mainnet.

---

## License
This project is licensed under the MIT License.

---

## Support
For questions or issues, please reach out:
- **Author**: Mohit Kapadiya
- **Email**: [Mohtajj@tanthetaa.com](mailto:codebymohit@gmail.com)
- **GitHub**: [github.com/<your-github-username>](https://github.com/codebymoh)

