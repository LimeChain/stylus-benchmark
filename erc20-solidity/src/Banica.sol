// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Banica is ERC20 {
    constructor() ERC20("Banica", "BANC") {}

    function mint(address recipient, uint256 amount) public {
        _mint(recipient, amount * 10 ^ decimals());
    }
}
