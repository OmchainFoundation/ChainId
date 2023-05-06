// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../interfaces/IChainIDRouter.sol";

contract CIDERC20 is ERC20, ERC20Burnable, Ownable {

    mapping(uint256 => uint256) private _balances;
    mapping(uint256 => mapping(uint256 => uint256)) private _allowances;

    IChainIDRouter public chainIDRouter;

    constructor(address chainIDRouter_) ERC20("Chain ID ERC20 Demo", "CIDERC20") {
        chainIDRouter = IChainIDRouter(chainIDRouter_);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    /**
     * The followings are overrides required for the ERC20 implementation 
     * work with the ChainID protocol
     */

    /**
     * @param chainIDRouter_ The address of the ChainIDRouter contract
     */
    function changeChainIDRouter(address chainIDRouter_) public onlyOwner {
        chainIDRouter = IChainIDRouter(chainIDRouter_);
    }

    /**
     * @param account The address of the account to check the balance of
     */
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[chainIDRouter.idOfAddress(account)];
    }

    /**
     * @param owner_ The address of the account to check the balance of
     */
    function allowance(address owner_, address spender) public view override returns (uint256) {
        return _allowances[chainIDRouter.idOfAddress(owner_)][chainIDRouter.idOfAddress(spender)];
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal override {
        require(from != address(0), "CIDERC20: transfer from the zero address");
        require(to != address(0), "CIDERC20: transfer to the zero address");

        uint256 accountID = chainIDRouter.idOfAddress(from);
        uint256 fromBalance = _balances[accountID];
        require(fromBalance >= amount, "CIDERC20: transfer amount exceeds balance");
        unchecked {
            _balances[accountID] = fromBalance - amount;
            _balances[chainIDRouter.idOfAddress(to)] += amount;
        }

        emit Transfer(from, to, amount);
    }

    function _mint(address account, uint256 amount) internal override {
        require(account != address(0), "CIDERC20: mint to the zero address");

        uint256 accountID = chainIDRouter.idOfAddress(account);
        _balances[accountID] += amount;
        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal override {
        require(account != address(0), "CIDERC20: burn from the zero address");

        uint256 accountID = chainIDRouter.idOfAddress(account);
        uint256 accountBalance = _balances[accountID];
        require(accountBalance >= amount, "CIDERC20: burn amount exceeds balance");
        unchecked {
            _balances[accountID] = accountBalance - amount;
        }

        emit Transfer(account, address(0), amount);
    }

    function _approve(
        address owner_,
        address spender,
        uint256 amount
    ) internal override {
        require(owner_ != address(0), "CIDERC20: approve from the zero address");
        require(spender != address(0), "CIDERC20: approve to the zero address");

        _allowances[chainIDRouter.idOfAddress(owner_)][chainIDRouter.idOfAddress(spender)] = amount;
        emit Approval(owner_, spender, amount);
    }

    function _spendAllowance(
        address owner_,
        address spender,
        uint256 amount
    ) internal override {
        uint256 spenderID = chainIDRouter.idOfAddress(spender);
        uint256 ownerID = chainIDRouter.idOfAddress(owner_);
        uint256 spenderAllowance = _allowances[ownerID][spenderID];
        require(spenderAllowance >= amount, "CIDERC20: transfer amount exceeds allowance");
        unchecked {
            _allowances[ownerID][spenderID] = spenderAllowance - amount;
        }
    }

}