pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Ed25519} from "../src/Ed25519.sol";

contract Deploy is Script {
    Ed25519 public ed25519;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        ed25519 = new Ed25519();

        vm.stopBroadcast();
    }
}

import {console} from "forge-std/console.sol";

contract Verify is Script {
    address ed25519Address = vm.envAddress("ED25519_ADDRESS");
    address recipientAddress = vm.envAddress("PUBLIC_KEY");
    Ed25519 ed25519;

    function setUp() public {
        ed25519 = Ed25519(ed25519Address);
    }

    function run() public {
        vm.startBroadcast();

        bytes memory message = hex"b0d8bdfd9f4d1023dae836b2e41da5019d20c60965dc40943e2c10f2ad4ee49ab0d8bdfd9f4d1023dae836b2e41da5019d20c60965dc";
        bytes memory signature = hex"a6161c95fd4e3237b7dd12cc3052aaa69382510ecb5b89c2fbeb8b6efb78266b81160af2842235a0257fc1d3e968c2c1c9f56f117da3186effcaeda256c38a0d";
        bytes32 public_key = 0x06cf14cfae0ff9fe7fdf773202029a3e8976465c8919f4840d1c3c77c8162435;

        ed25519.verify(message, signature, public_key);

        vm.stopBroadcast();
    }
}
