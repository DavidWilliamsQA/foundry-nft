// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public nft;
    address public USER = makeAddr("USER");
    string public constant PANTHERS =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        nft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Football";
        string memory actualName = nft.name();
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(USER);
        nft.mintNft(PANTHERS);
        uint256 balance = nft.balanceOf(USER);
        assert(balance == 1);
        assert(
            keccak256(abi.encodePacked(PANTHERS)) ==
                keccak256(abi.encodePacked(nft.tokenURI(0)))
        );
    }
}