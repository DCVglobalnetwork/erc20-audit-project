// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Import Test contract from forge-std for unit testing
import {Test} from "forge-std/Test.sol";
// Import the MyERC20Token contract
import {MyERC20Token} from "../contracts/MyERC20Token.sol";
// Import the IERC20Metadata interface from OpenZeppelin library
import {IERC20Metadata} from "lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol";

// Define the ERC20Test contract that inherits from the Test contract
contract ERC20Test is Test {
    // Declare a MyERC20Token variable to hold the instance of the token contract
    MyERC20Token token;

    // setUp function to deploy the token contract before each test
    function setUp() public {
        // Deploy a new instance of the MyERC20Token contract with name "My Token" and symbol "MTK"
        token = new MyERC20Token("My Token", "MTK");
    }

    // Test case to check the total supply of tokens
    function testTotalSupply() public {
        // Assert that the total supply is equal to 1,000,000 tokens with 18 decimals
        assertEq(token.totalSupply(), 1000000 * 10 ** uint(token.decimals()));
    }

    // Test case to check the name of the token
    function testName() public {
        // Assert that the name of the token is "My Token"
        assertEq(token.name(), "My Token");
    }

    // Test case to check the symbol of the token
    function testSymbol() public {
        // Assert that the symbol of the token is "MTK"
        assertEq(token.symbol(), "MTK");
    }

    // Test case to check the number of decimals of the token
    function testDecimals() public {
        // Assert that the number of decimals of the token is 18
        assertEq(token.decimals(), 18);
    }

    // Test case to check the balance of an account
    function testBalanceOf() public {
        // Define an address for the account
        address account = address(0xBEEF);
        // Assert that the initial balance of the account is 0
        assertEq(token.balanceOf(account), 0);
        // Transfer 1,000 tokens to the account
        token.transfer(account, 1000 * 10 ** uint(token.decimals()));
        // Assert that the balance of the account is now 1,000 tokens
        assertEq(token.balanceOf(account), 1000 * 10 ** uint(token.decimals()));
    }

    // Test case to check the transfer function
    function testTransfer() public {
        // Define addresses for the sender and recipient
        address sender = address(this);
        address recipient = address(0xBEEF);
        // Transfer 500 tokens from sender to recipient
        token.transfer(recipient, 500 * 10 ** uint(token.decimals()));
        // Assert that the balance of the sender is reduced by 500 tokens
        assertEq(
            token.balanceOf(sender),
            999500 * 10 ** uint(token.decimals())
        );
        // Assert that the balance of the recipient is increased by 500 tokens
        assertEq(
            token.balanceOf(recipient),
            500 * 10 ** uint(token.decimals())
        );
    }

    // Test case to check the transferFrom function
    function testTransferFrom() public {
        // Define addresses for the sender and recipient
        address sender = address(this);
        address recipient = address(0xBEEF);
        // Approve the sender to spend 1,000 tokens on behalf of the recipient
        token.approve(sender, 1000 * 10 ** uint(token.decimals()));
        // Transfer 500 tokens from the sender to the recipient using transferFrom
        token.transferFrom(
            sender,
            recipient,
            500 * 10 ** uint(token.decimals())
        );
        // Assert that the balance of the sender is reduced by 500 tokens
        assertEq(
            token.balanceOf(sender),
            999500 * 10 ** uint(token.decimals())
        );
        // Assert that the balance of the recipient is increased by 500 tokens
        assertEq(
            token.balanceOf(recipient),
            500 * 10 ** uint(token.decimals())
        );
    }

    // Test case to check the allowance function
    function testAllowance() public {
        // Define addresses for the owner and spender
        address owner = address(this);
        address spender = address(0xBEEF);
        // Approve the spender to spend 1,000 tokens on behalf of the owner
        token.approve(spender, 1000 * 10 ** uint(token.decimals()));
        // Assert that the allowance for the spender is 1,000 tokens
        assertEq(
            token.allowance(owner, spender),
            1000 * 10 ** uint(token.decimals())
        );
    }
}
