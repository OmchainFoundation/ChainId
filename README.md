## Notice

Chain ID is in alpha release, which means there are no tests or smart contract audits as of now. There might be bugs on the smart contract or some functionality might not work as intended. For that reason please use the smart contracts given here with caution.

# Chain ID

The Chain ID protocol is an on-chain identification solution based on a soulbound ERC721 token. The purpose of this protocol is to provide a secure, decentralized way for organizations to associate unique IDs with specific blockchain addresses, and to enable transfers of ownership of those IDs through standard ERC721 transfer functions.

The Chain ID contract is designed to be flexible and customizable, allowing organizations to implement the protocol in a way that meets their specific needs. By using a soulbound ERC721 token, the protocol ensures that each ID is uniquely tied to a specific blockchain address and cannot be transferred without the owner's consent.

The Chain ID contract can be used in a wide range of applications where secure, decentralized identification is required. By integrating with the Chain ID protocol, organizations can enhance the security and reliability of their identification systems, and provide a trusted, decentralized source of identity verification for their users.

## Features

* Secure, decentralized identification based on a soulbound ERC721 token
* Customizable implementation to meet specific needs of organizations
* Enables transfers of ownership of IDs through standard ERC721 transfer functions
* Provides a trusted, decentralized source of identity verification for a wide range of applications
* Follows a role based permission system, enabling programmatic minting and burning NFTs via backend services

## Usage
To use the Chain ID protocol, organizations will need to deploy the Chain ID and ChainIDRouter contracts to their EVM-compatible blockchain using a tool like Hardhat. Once the contracts are deployed, they can be integrated into existing systems and applications using the standard ERC721 transfer functions.

For example, an organization might use the Chain ID contract to issue unique IDs to their users. These IDs could be transferred between accounts as needed by the operator, and used to verify identity for a variety of applications. By using a soulbound ERC721 token, the organization can ensure that each ID is uniquely tied to a specific blockchain address and cannot be transferred without the operator's consent.

## 3rd Party Integrations
Integrating with an existing Chain ID deployment is relatively straightforward. First you need to learn the address of the ChainIDRouter contract for the organization you wish to integrate with. 

Once you have the ChainID Router contract address, you can import `IChainIDRouter.sol` - the interface for ChainID Router - in your smart contracts to retrieve the unique identifier for any address on the network. To do this, you simply call the idOfAddress() function on the ChainID Router contract and pass in the address you want to retrieve the ID for.

In the demo contract provided, the `CIDERC20` token contract extends the `ERC20` and `ERC20Burnable` contracts from OpenZeppelin and overrides several functions to work with the ChainID protocol.

The `balanceOf()` and `allowance()` functions have been overridden to retrieve the balance and allowance for the ID associated with the address instead of the address itself. Similarly, the `_transfer()`, `_mint()`, `_burn()`, and `_approve()` functions have been overridden to use the ID associated with the addresses instead of the addresses themselves.

The contract also includes a function to change the ChainID Router address if needed.

## License
The Chain ID contract is licensed under the MIT License. Please see the LICENSE file for more information.



