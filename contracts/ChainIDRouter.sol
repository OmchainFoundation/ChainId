// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "./interfaces/IChainID.sol";

contract ChainIDRouter {

  address public chainID;
  address public owner;

  constructor(address _chainID) {
    chainID = _chainID;
    owner = msg.sender;
  }

  function setChainIDAddress(address _chainID) public {
    require(msg.sender == owner, "ChainIDRouter: only owner can set chainID");
    chainID = _chainID;
  }

  function idOfAddress(address addr) public view returns (uint256) {
    return IChainID(chainID).idOfAddress(addr);
  }

  function transferOwnership(address newOwner) public {
    require(msg.sender == owner, "ChainIDRouter: only owner can transfer ownership");
    owner = newOwner;
  }

}