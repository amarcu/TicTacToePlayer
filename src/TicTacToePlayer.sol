// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
import "./interfaces/ITicTacToeGame.sol";
import "./core/BasePlayer.sol";

/// @title TicTacToePlayer
/// @notice Starter TicTacToe player contract
contract TicTacToePlayer is BasePlayer {

    /// ======== Storage ======== ///

    /// Game contract containing the game board and a few helper functions
    /// For more information on the helper functions check the `ITicTacToeGame` interface
    ITicTacToeGame public game;
    constructor() BasePlayer() {}

    /// ======== Base Implementation - Do not edit ======== ///

    /// @notice Init the player, this is called automatically after the player is created
    /// @param gameAddress Address of the game contract
    /// @param index_ Internal index of the player[0 or 1]
    function init(address gameAddress, uint256 index_)
        public
        override(BasePlayer)
    {
        super.init(gameAddress, index_);
        game = ITicTacToeGame(gameAddress);
    }

    /// ======== Move function, edit me ======== ///

    /// @notice The move function is called every turn and it`s expected to return a valid move output
    /// @dev The player is disqualified if:
    /// - the output is not a valid move
    /// - the function reverts
    /// - the function consumes more than 2.000.000 gas
    /// @param /*input*/ The input is the last move of our opponent
    /// To keep the contract simple the input is not used but it should be used for a competitive algorithm
    /// @return output encoded Coords structure with our move for this turn
    function move(bytes memory /*input*/)
        external
        view
        override(BasePlayer)
        returns (bytes memory output)
    {
        // the demo move function will always select and return the first playable cell it can find

        // if we are bound to a grid then search and return the first empty cell
        if (game.useCurrentGrid()) {
            return abi.encode(_getMove(game.getCurrentGridCoords(), game.getCurrentGrid()));
        } else {
            // if we are not bound to a grid then we can select any cell
            // so we search for the first grid that has an empty cell and
            // return the first empty cell we can find
            Grid memory globalGrid = game.getGlobalGrid();
            for (uint256 globalX = 0; globalX < 3; ++globalX) {
                for (uint256 globalY = 0; globalY < 3; ++globalY) {
                    if (globalGrid.cells[globalX][globalY] == 0) {
                        return abi.encode(_getMove(
                            Coords(uint128(globalX), uint128(globalY)),
                            game.getLocalGrid(globalX, globalY)
                        ));
                    }
                }
            }
        }
        output = "";
    }

    /// ======== Helper functions ======== ///

    /// @notice Return the first empty cell in a grid
    /// @param coords The global coordinates of the grid
    /// @param grid The grid we need to return the cell for
    /// @return move_ The global coordinates of the first empty cell we find in `grid`
    function _getMove(Coords memory coords, Grid memory grid)
        internal
        view
        returns (Coords memory move_)
    {
        for (uint256 localX = 0; localX < 3; ++localX) {
            for (uint256 localY = 0; localY < 3; ++localY) {
                if (grid.cells[localX][localY] == 0) {
                    // convert to global coordinates
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
