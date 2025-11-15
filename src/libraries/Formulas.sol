// SPDX-License-Identifier: CC0
pragma solidity 0.8.30;

interface Formula {
    function Const(uint256 val) external;
    function Query(
        bytes memory target, // ERC-7930 Address
        bytes4 selector,
        bytes[] memory arguments, // Argument Encoding
        uint256 blockNumber
    )
        external;
}

library Formulas {
    function Const(uint256 val) internal pure returns (bytes memory) {
        return abi.encodeCall(Formula.Const, (val));
    }

    function Query(
        bytes memory target, // ERC-7930 Address
        bytes4 selector,
        bytes[] memory arguments, // Argument Encoding
        uint256 blockNumber
    )
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeCall(Formula.Query, (target, selector, arguments, blockNumber));
    }
}
