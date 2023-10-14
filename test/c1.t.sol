// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/c1.sol";

contract BannableTokenTest is Test {

    BannableToken private token;
    address public user1 = vm.addr(1);

    function setUp() public {
        vm.prank(user1);
        token = new BannableToken("Test Token", "TT", 1000 ether);
        token.transfer(address(this), 100 ether);
    }

    function testBanAddress() public {
        address accountToBan = address(0x123);
        assertTrue(!token.isAddressBanned(accountToBan), "Account should not be initially banned");

        token.banAddress(accountToBan, true);

        assertTrue(token.isAddressBanned(accountToBan), "Account should be banned");

        token.banAddress(accountToBan, false);

        assertTrue(!token.isAddressBanned(accountToBan), "Account should be unbanned");
    }

    function testFailTransfer() public {
        address sender = address(this);
        address recipient = address(0x456);
        uint256 amount = 10 ether;

        assertTrue(token.transfer(recipient, amount), "Transfer should succeed");

        assertTrue(!token.isAddressBanned(sender), "Sender should not be banned");
        assertTrue(!token.isAddressBanned(recipient), "Recipient should not be banned");

        token.banAddress(sender, true);

        assertTrue(token.transfer(recipient, amount), "Transfer should fail when sender is banned");
    }
}
