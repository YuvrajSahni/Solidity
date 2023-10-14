// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract ConsoleTest is Test{
    function testLog() public{
        console.log("Log something ",123);
        int x=-1;
        console.logInt(x);
    }
}