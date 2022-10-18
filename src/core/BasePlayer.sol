pragma solidity ^0.8.13;

abstract contract BasePlayer {
    uint256 public index;

    bool public isInitialized;

    constructor() {
        isInitialized = false;
    }

    function init(
        address, /*gameAddress*/
        uint256 index_
    ) public virtual {
        index = index_;
        isInitialized = true;
    }

    function move() external view virtual returns (bytes memory output);
}
