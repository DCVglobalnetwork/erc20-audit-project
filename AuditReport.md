# Smart Contract Audit Report

Project Name: MyERC20Token
Audit Date: 28/06/2024
Auditor: Magda Jankowska

## Table of Contents

Introduction
Scope
Methodology
Findings
4.1 Critical Issues
4.2 High Issues
4.3 Medium Issues
4.4 Low Issues
4.5 Informational Issues
Recommendations
Conclusion


## Introduction
This report provides a detailed audit of the `MyERC20Token` smart contract. The primary goal of the audit is to ensure the security and correctness of the smart contract's implementation.

### Scope

The audit covers the following files:

`MyERC20Token.sol`
`ERC20Test.sol`

The focus is on identifying security vulnerabilities, including but not limited to:

Reentrancy attacks
Integer overflows/underflows
Correctness of the business logic
Compliance with the ERC20 standard


### Methodology

The audit process involves:

Manual Code Review: 

Inspecting the code for logical errors, security vulnerabilities, and compliance with best practices.
Automated Analysis: Using tools to detect common vulnerabilities and patterns in the smart contract code.
Testing: Reviewing the provided test cases and writing additional test cases if necessary to cover edge cases and potential attack vectors.


### Findings

**High Severity Issues**

*No high severity issues were identified in this contract.*


**Medium Severity Issues**

*Centralized Control of Initial Supply*

*Description:*
The entire initial supply of 1,000,000 tokens is minted to the deployer’s address. This gives the deployer full control over the initial token supply.

*Impact:* 
This can be a significant centralization risk if not handled properly. If the deployer's private key is compromised or if the deployer acts maliciously, the entire token supply is at risk.

*Recommendation:* 
Implement a vesting schedule or distribute the initial supply among multiple addresses or through a decentralized mechanism.


**Low Severity Issues**

*Lack of Events for Minting*

*Description:* 
While the _mint function internally emits a Transfer event, it is considered best practice to explicitly document and handle important actions such as minting.

*Impact:*
Improves transparency and traceability of key operations.

*Recommendation:* 
Ensure that all critical actions are well-documented, and consider emitting custom events for significant state changes if necessary.

*Hardcoded Initial Supply*

*Description:*
The initial supply of tokens is hardcoded in the constructor.

*Impact:*
This limits flexibility. Any change to the initial supply would require redeploying a new contract.

*Recommendation:* 
Consider making the initial supply a constructor parameter, allowing for more flexibility when deploying the contract.

## Detailed Code Review

Contract: MyERC20Token
solidity
```shell
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
```

Comments:

The contract correctly imports and extends OpenZeppelin's ERC20 implementation.
The constructor mints a fixed supply of tokens to the deployer's address.

Contract: ERC20Test
solidity
```shell
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

```

Comments:

The setUp function correctly initializes the MyERC20Token contract.
Test cases cover basic functionalities of the ERC20 token such as totalSupply, name, symbol, decimals, balanceOf, transfer, transferFrom, and allowance.

## Recommendations

1. **Distribute Initial Supply**
    Modify the constructor to allow for a more flexible distribution of the initial supply:

    ```solidity
    constructor(string memory name, string memory symbol, address[] memory initialHolders, uint256[] memory initialAmounts) ERC20(name, symbol) {
        require(initialHolders.length == initialAmounts.length, "Mismatched arrays");
        for (uint256 i = 0; i < initialHolders.length; i++) {
            _mint(initialHolders[i], initialAmounts[i]);
        }
    }
    ```

    This ensures a more decentralized initial distribution and reduces the centralization risk.

    
 2. **Consider Vesting or Timelock**
    Implementing a vesting schedule or a timelock mechanism for the initial supply could mitigate risks associated with centralized control:

    ```solidity
    // Example of a simple vesting schedule implementation
    contract TokenVesting {
        MyERC20Token public token;
        uint256 public releaseTime;
        
        constructor(MyERC20Token _token, uint256 _releaseTime) {
            require(_releaseTime > block.timestamp, "Release time is before current time");
            token = _token;
            releaseTime = _releaseTime;
        }
        
        function release() public {
            require(block.timestamp >= releaseTime, "Current time is before release time");
            uint256 amount = token.balanceOf(address(this));
            require(amount > 0, "No tokens to release");
            token.transfer(msg.sender, amount);
        }
    }
    ```

3. **Explicit Minting Events**
    Ensure clarity by documenting the minting process explicitly:

    ```solidity
    event Mint(address indexed to, uint256 amount);

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        uint256 initialSupply = 1000000 * 10 ** uint(decimals());
        _mint(msg.sender, initialSupply);
        emit Mint(msg.sender, initialSupply);
    }
    ```

By following these recommendations, you can improve the security, flexibility, and transparency of your smart contract, ensuring better alignment with best practices and reducing potential risks.

---

## Conclusion

The `MyERC20Token` contract and its associated test cases are well-implemented and follow best practices for ERC20 tokens. The audited contracts demonstrate a basic implementation of an ERC20 token and its corresponding tests. While the current implementation is secure, following the provided recommendations will enhance the security and robustness of the contracts.

---

