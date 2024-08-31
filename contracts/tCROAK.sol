// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract tCROAK is ERC20, ERC20Permit {

    uint256 constant SUPPLY = 2_015_000_000;

    constructor() ERC20("$CROAK", "tCROAK") ERC20Permit("$CROAK") {
        _mint(msg.sender, SUPPLY * 10 ** decimals());
    }
}
