// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Ed25519Lib} from "./lib/Ed25519.sol";

contract Ed25519 {
    constructor() {}

    function verify(
        bytes calldata message,
        bytes calldata signature,
        bytes32 public_key
    ) public returns (bool) {
        require(signature.length == 64, "Invalid signature length");

        bytes32 r;
        bytes32 s;
        assembly {
            calldatacopy(add(r, 0x20), add(signature.offset, 0x20), 32)

            calldatacopy(add(s, 0x20), add(signature.offset, 0x40), 32)
        }

        return Ed25519Lib.verify(public_key, r, s, message);
    }
}
