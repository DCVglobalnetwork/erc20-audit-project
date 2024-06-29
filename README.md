# ERC20 Audit Project

This project demonstrates the development and testing of an ERC20 token using Solidity, OpenZeppelin libraries, and Foundry. It includes the implementation of the ERC20 token and a comprehensive suite of unit tests to ensure its functionality and security.

## Table of Contents

- [Introduction](#introduction)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Usage](#usage)
- [Testing](#testing)
- [Development and Testing Environment](#development-and-testing-environment)
- [License](#license)

## Introduction

The project contains the following:
1. A smart contract (`MyERC20Token.sol`) that implements a basic ERC20 token.
2. Unit tests (`ERC20Test.sol`) to verify the correctness of the ERC20 token's functionality.

## Project Structure

├── contracts
│ └── MyERC20Token.sol # ERC20 Token implementation
├── lib
│ └── openzeppelin-contracts # OpenZeppelin library for secure smart contract development
├── test
│ └── ERC20Test.sol # Unit tests for the ERC20 Token
├── foundry.toml # Foundry configuration file
├── .gitignore # Git ignore file
└── README.md # Project README


## Installation

To set up the development environment, follow these steps:

1. **Install Foundry**:
   ```sh
   curl -L https://foundry.paradigm.xyz | bash
   foundryup

Clone the Repository:

```sh
git clone <your-repository-url>
cd <your-repository-directory>
```

Install Dependencies:

```sh
forge install OpenZeppelin/openzeppelin-contracts
```

## Usage

Compile the smart contracts using Foundry:
```sh
forge build
```

## Testing

Run the unit tests to verify the functionality of the contracts:
```sh
forge test
```

## Development and Testing Environment

The smart contracts and tests were developed and tested using the following tools and libraries:

Solidity: Version 0.8.20
Foundry: A fast and flexible Ethereum testing framework
OpenZeppelin Contracts: A library for secure smart contract development
Forge-std: A standard library for unit testing in Foundry
Steps to Reproduce
Setup the Development Environment:
Ensure you have Foundry installed. If not, install it using:

```sh
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

Clone the Project Repository:

```sh
git clone https://github.com/DCVglobalnetwork/erc20-audit-project.git
cd erc20-audit-project
```

Install Dependencies:
Use Foundry to install OpenZeppelin contracts:

```sh
forge install OpenZeppelin/openzeppelin-contracts
```
Compile the Contracts:
Compile the smart contracts using Foundry:
```sh
forge build
```
Run the Tests:
Execute the unit tests to verify the functionality of the contracts:
```sh
forge test
```

## License

This project is licensed under the MIT License. See the LICENSE file for details.




