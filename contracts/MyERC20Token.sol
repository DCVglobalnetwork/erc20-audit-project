// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Import the ERC20 implementation from OpenZeppelin library
import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

// Define the contract MyERC20Token that inherits from OpenZeppelin's ERC20 implementation
contract MyERC20Token is ERC20 {
    // The constructor is executed when the contract is deployed
    // It takes two parameters: name and symbol of the token
    // It calls the ERC20 constructor with these parameters to set the token's name and symbol
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        // Mint 1,000,000 tokens to the deployer's address
        // The amount is in wei, so we multiply by 10^decimals() to get the correct token amount
        // `decimals()` is a function from the ERC20 implementation that returns the number of decimals used by the token (default is 18)
        _mint(msg.sender, 1000000 * 10 ** uint(decimals()));
    }
}
