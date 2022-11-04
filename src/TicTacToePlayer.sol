// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
import "./interfaces/ITicTacToeGame.sol";
import "./core/BasePlayer.sol";

///@notice
contract TicTacToePlayer is BasePlayer {
    ITicTacToeGame public game;
    constructor() BasePlayer() {}

    function init(address gameAddress, uint256 index_)
        public
        override(BasePlayer)
    {
        super.init(gameAddress, index_);
        game = ITicTacToeGame(gameAddress);
    }

    function move()
        external
        view
        override(BasePlayer)
        returns (bytes memory output)
    {
        if (game.useCurrentGrid()) {
            return abi.encode(_getMove(game.getCurrentGridCoords(), game.getCurrentGrid()));
        } else {
            Grid memory globalGrid = game.getGlobalGrid();
            for (uint256 globalX = 0; globalX < 3; ++globalX) {
                for (uint256 globalY = 0; globalY < 3; ++globalY) {
                    if (globalGrid.cells[globalX][globalY] == 0) {
                        Coords memory currentMove = _getMove(
                            Coords(uint128(globalX), uint128(globalY)),
                            game.getLocalGrid(globalX, globalY)
                        );
                        return abi.encode(currentMove);
                    }
                }
            }
        }
        output = "";
    }

    function _getMove(Coords memory coords, Grid memory grid)
        internal
        view
        returns (Coords memory move_)
    {
        for (uint256 localX = 0; localX < 3; ++localX) {
            for (uint256 localY = 0; localY < 3; ++localY) {
                if (grid.cells[localX][localY] == 0) {
                    move_ = game.toGlobalCoords(
                        coords,
                        Coords(uint128(localX), uint128(localY))
                    );

                    return move_;
                }
            }
        }
    }
}
