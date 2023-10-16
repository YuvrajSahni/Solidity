// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Escrow {
	address public arbiter;
	address public beneficiary;
	address public depositor;

	event Approved(uint);

	constructor(address _arbiter, address _beneficiary) payable {
		arbiter = _arbiter;
		beneficiary = _beneficiary;
		depositor = msg.sender;
	}

	error NotAuthorized();

	function approve() external {
		if(msg.sender != arbiter) revert NotAuthorized();
		
		(bool success, ) = beneficiary.call{ value: address(this).balance }("");
		require(success);

		emit Approved(beneficiary.balance);
	}
}
