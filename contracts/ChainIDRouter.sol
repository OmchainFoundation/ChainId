// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "./interfaces/IChainID.sol";
import "./interfaces/IERC721.sol";

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
    uint256 id = IChainID(chainID).idOfAddress(addr);
    require(id != 0, "Address not registered");
    return id;
  }

  function addressOfId(uint256 id) public view returns (address) {
    address owner_ = IERC721(chainID).ownerOf(id);
    require (owner_ != address(0), "ID not registered");
    return owner_;
  }

  function transferOwnership(address newOwner) public {
    require(msg.sender == owner, "ChainIDRouter: only owner can transfer ownership");
    owner = newOwner;
  }

}