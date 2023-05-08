// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

interface IChainIDRouter {
  function idOfAddress(address addr) external view returns (uint256);
  function addressOfId(uint256 id) external view returns (address);
}