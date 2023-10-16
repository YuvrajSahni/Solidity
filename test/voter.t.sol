// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/voter.sol";

contract ContractTest is Test {
    Contract public myContract;
    address votingAddr = address(2);

    function setUp() public {
        vm.startPrank(votingAddr);
        myContract = new Contract();
    }

    function testVoteYes() public {
        myContract.createVote(Contract.Choices.Yes);
        assertEq(myContract.hasVoted(votingAddr), true, "it should register the address as having voted");
        vm.expectRevert();
        myContract.createVote(Contract.Choices.Yes);
    }

    function testVoteNo() public {
        myContract.createVote(Contract.Choices.No);
        assertEq(myContract.hasVoted(votingAddr), true, "it should register the address as having voted");
        vm.expectRevert();
        myContract.createVote(Contract.Choices.No);
    }

     function testVoteTwiceRevert() public {
        myContract.createVote(Contract.Choices.Yes);
        vm.expectRevert();
        myContract.createVote(Contract.Choices.Yes);
    }

    function testVoteChange() public {
        myContract.createVote(Contract.Choices.No);
        Contract.Choices choice = myContract.findChoice(votingAddr);
        assertEq(uint(choice), uint(Contract.Choices.No));

        myContract.changeVote(Contract.Choices.Yes);
        choice = myContract.findChoice(votingAddr);
        assertEq(uint(choice), uint(Contract.Choices.Yes));
    }
}
