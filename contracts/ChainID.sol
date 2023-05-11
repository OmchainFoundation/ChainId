// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "./interfaces/IChainID.sol";
import "./tokens/SoulboundERC721.sol";

contract ChainID is IChainID, SoulboundERC721 {

    mapping(address => uint256) public idOfAddress_;

    constructor() SoulboundERC721("ChainID", "CID") {}

    function idOfAddress (address addr) public view returns (uint256) {
        return idOfAddress_[addr];
    }

    function safeMint(address to, uint256 tokenId) public override(IChainID, SoulboundERC721) onlyRole(MINTER_ROLE) {
        require(idOfAddress_[to] == 0, "ChainID: address already has a token");
        _safeMint(to, tokenId);
        idOfAddress_[to] = tokenId;
    }

    function burn(uint256 tokenId) public override(IChainID, SoulboundERC721) onlyRole(BURNER_ROLE) {
        address owner = ownerOf(tokenId);
        _burn(tokenId);
        idOfAddress_[owner] = 0;
    }

    function transferFrom(address from, address to, uint256 tokenId) public override onlyRole(OPERATOR_ROLE) {
        require(idOfAddress_[to] == 0, "ChainID: address already has a token");
        _transfer(from, to, tokenId);
        idOfAddress_[from] = 0;
        idOfAddress_[to] = tokenId;
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public override onlyRole(OPERATOR_ROLE) {
        safeTransferFrom(from, to, tokenId, "");
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public override onlyRole(OPERATOR_ROLE) {
        require(idOfAddress_[to] == 0, "ChainID: address already has a token");
        _safeTransfer(from, to, tokenId, data);
        idOfAddress_[from] = 0;
        idOfAddress_[to] = tokenId;
    }

}