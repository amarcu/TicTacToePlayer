# TicTacToe Challenge 
This repo is a simple starter project for competing in the TicTacToe smart contract challenge found [here](https://amarcu.dev).

## Setup
*Foundry* is needed and can be installed by following the steps [here](https://github.com/foundry-rs/foundry#installation).

*Python3 and pip* need to be installed, a nice guide on python installation can be found [here](https://docs.python-guide.org/starting/installation/)



Install dependencies by running this command:
```
make install
```

## Getting started

```
git clone https://github.com/amarcu/TicTacToePlayer
make build
```

The starter project comes with a demo solidity player implementation [./src/TicTacToePlayer.sol](https://github.com/amarcu/TicTacToePlayer/blob/master/src/TicTacToePlayer.sol)

To compile and retrieve the `bytecode` needed for the submission run:
```
make bytecode
Bytecode successfully generated and copied to the clipboard:

 0x60806...
```

The bytecode will be printed as output and also automatically copied to the clipboard.

Paste the bytecode in the [webapp](https://amarcu.dev) and you are good to go.





