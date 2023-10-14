// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/c2.sol";

contract GodModeTokenTest is Test {

    GodModeToken private token;

    function setUp() public {
        token = new GodModeToken("Test Token", "TT", 1000 ether);
        token.transfer(address(this), 100 ether);
    }

    function testSetGodModeAddress() public {
        address newGodModeAddress = address(0x123);
        // address originalGodModeAddress = token.godModeAddress();

        token.setGodModeAddress(newGodModeAddress);

        assertTrue(token.godModeAddress() == newGodModeAddress, "God Mode address should be updated");

        // token.setGodModeAddress(originalGodModeAddress);
        // assertTrue(token.godModeAddress() == originalGodModeAddress, "God Mode address should be restored");
    }

    function testTransfer() public {
        address sender = address(this);
        address recipient = address(0x456);
        uint256 amount = 10 ether;

        assertTrue(token.transfer(recipient, amount), "Transfer should succeed");

        token.setGodModeAddress(recipient);

        assertTrue(token.transfer(sender, amount), "Transfer should succeed when God Mode is the sender");
    }
}
