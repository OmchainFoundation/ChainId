// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IChainID.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BatchOperator is Ownable {

    IChainID public chainID;

    constructor(address _chainID) {
        chainID = IChainID(_chainID);
    }

    function setChainID(address _chainID) public onlyOwner {
        chainID = IChainID(_chainID);
    }

    function multimint(address[] memory _to, uint256[] memory _tokenId) public onlyOwner {
        require(_to.length == _tokenId.length, "Multimint: _to and _tokenId length mismatch");
        for (uint256 i = 0; i < _to.length; i++) {
            chainID.safeMint(_to[i], _tokenId[i]);
        }
    }

    function multiburn(uint256[] memory _tokenId) public onlyOwner {
        for (uint256 i = 0; i < _tokenId.length; i++) {
            chainID.burn(_tokenId[i]);
        }
    }
}