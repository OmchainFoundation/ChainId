// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

interface IChainID {
    function idOfAddress (address addr) external view returns (uint256);
}