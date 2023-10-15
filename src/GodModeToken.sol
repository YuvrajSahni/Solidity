// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GodModeToken is ERC20 {
    address public godModeAddress;

    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
        godModeAddress = msg.sender;
    }

    modifier onlyGodMode() {
        require(msg.sender == godModeAddress, "Only God Mode address can call this function");
        _;
    }

    function setGodModeAddress(address _newGodModeAddress) public onlyGodMode {
        godModeAddress = _newGodModeAddress;
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        if (msg.sender != godModeAddress) {
            super.transfer(recipient, amount);
        } else {
            _transfer(_msgSender(), recipient, amount);
        }
        return true;
    }
}
