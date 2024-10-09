pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Banica} from "../src/Banica.sol";

contract Deploy is Script {
    Banica public banica;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        banica = new Banica();

        vm.stopBroadcast();
    }
}

contract Mint is Script {
    address contractAddress = vm.envAddress("CONTRACT_ADDRESS");
    address recipientAddress = vm.envAddress("PUBLIC_KEY");
    Banica banica;

    function setUp() public {
        banica = Banica(contractAddress);
    }

    function run() public {
        vm.startBroadcast();

        banica.mint(recipientAddress, 10);

        vm.stopBroadcast();
    }
}

contract Transfer is Script {
    address contractAddress = vm.envAddress("CONTRACT_ADDRESS");
    Banica banica;

    function setUp() public {
        banica = Banica(contractAddress);
    }

    function run() public {
        vm.startBroadcast();

        banica.transfer(address(0x1), 1);

        vm.stopBroadcast();
    }
}
