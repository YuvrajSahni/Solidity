// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BannableToken is ERC20, Ownable {

    mapping(address => bool) private banned;

    event AddressBanned(address indexed bannedAddress, bool isBanned);

    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
    }

    function banAddress(address _address, bool _isBanned) external onlyOwner {
        banned[_address] = _isBanned;
        emit AddressBanned(_address, _isBanned);
    }

    function transfer(address to, uint256 value) public override returns (bool) {
        require(!banned[msg.sender], "Sender is banned");
        require(!banned[to], "Recipient is banned");
        return super.transfer(to, value);
    }

    function transferFrom(address from, address to, uint256 value) public override returns (bool) {
        require(!banned[from], "Sender is banned");
        require(!banned[to], "Recipient is banned");
        return super.transferFrom(from, to, value);
    }

    function isAddressBanned(address _address) external view returns (bool) {
        return banned[_address];
    }
}
