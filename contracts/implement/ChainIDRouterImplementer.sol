// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "../interfaces/IChainIDRouter.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ChainIDRouterImplementer is Ownable, IChainIDRouter {
    IChainIDRouter public chainIDRouter;

    constructor(address _chainIDRouter) {
        chainIDRouter = IChainIDRouter(_chainIDRouter);
    }

    function setChainIDRouter(address _chainIDRouter) public onlyOwner {
        chainIDRouter = IChainIDRouter(_chainIDRouter);
    }

    function idOfAddress(address addr) public view returns (uint256) {
        return chainIDRouter.idOfAddress(addr);
    }

    function addressOfId(uint256 id) public view returns (address) {
        return chainIDRouter.addressOfId(id);
    }

}