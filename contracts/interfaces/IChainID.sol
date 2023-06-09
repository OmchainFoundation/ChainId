// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

interface IChainID {
    function idOfAddress (address addr) external view returns (uint256);
    function safeMint (address to, uint256 tokenId) external;
    function burn (uint256 tokenId) external;
}