// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.8.2) (token/ERC721/ERC721.sol)

pragma solidity ^0.8.0;

import "./ERC721.sol";
import "../access/AccessControl.sol";

/**
 * @dev Implementation of https://eips.ethereum.org/EIPS/eip-721[ERC721] Non-Fungible Token Standard, including
 * the Metadata extension, but not including the Enumerable extension, which is available separately as
 * {ERC721Enumerable}.
 */
contract SoulboundERC721 is ERC721, AccessControl {

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR_ROLE");

    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {
      _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
      _grantRole(MINTER_ROLE, msg.sender);
      _grantRole(BURNER_ROLE, msg.sender);
      _grantRole(OPERATOR_ROLE, msg.sender);
    }

    function safeMint(address to, uint256 tokenId) public virtual onlyRole(MINTER_ROLE) {
        _safeMint(to, tokenId);
    }

    function burn(uint256 tokenId) public virtual onlyRole(BURNER_ROLE) {
        _burn(tokenId);
    }

    function transferFrom(address from, address to, uint256 tokenId) public virtual override onlyRole(OPERATOR_ROLE) {
        _transfer(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public virtual override onlyRole(OPERATOR_ROLE) {
        safeTransferFrom(from, to, tokenId, "");
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public virtual override onlyRole(OPERATOR_ROLE) {
        _safeTransfer(from, to, tokenId, data);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

}
