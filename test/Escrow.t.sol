// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Escrow.sol";

contract EscrowTest is Test {
    Escrow public escrow;
    address arbiter = address(2);
    address depositor = address(3);
    address payable beneficiary = payable(address(4));

	event Approved(uint);

    function setUp() public {
        hoax(depositor);
        escrow = new Escrow{ value: 1 ether }(arbiter, beneficiary);
    }

    function testAddresses() public {
        assertEq(escrow.arbiter(), arbiter);
        assertEq(escrow.depositor(), depositor);
        assertEq(escrow.beneficiary(), beneficiary);
    }

    function testAsOther() public {
        vm.prank(depositor);
        vm.expectRevert();
        escrow.approve();

        vm.prank(beneficiary);
        vm.expectRevert();
        escrow.approve();
    }

    function testAsArbiter() public {
        vm.prank(arbiter);
        escrow.approve();

        assertEq(beneficiary.balance, 1 ether);
    }

    function testEmitApproveEvent() public {
        vm.expectEmit(false, false, false, true);
        emit Approved(1 ether);
        vm.prank(arbiter);
        escrow.approve();
    }

}
