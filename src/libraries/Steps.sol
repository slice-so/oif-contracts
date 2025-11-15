// SPDX-License-Identifier: CC0
pragma solidity 0.8.30;

interface Step {
    function Call(
        bytes memory target, // ERC-7930 Interoperable Address
        bytes4 selector,
        bytes[] memory arguments, // Argument Encoding
        bytes[] memory attributes, // Attribute[] (Tagged Union Encoding)
        uint256[] memory dependencySteps, // Steps by index in resolved order
        bytes[] memory payments // Payment[] (Tagged Union Encoding)
    ) external;

    function FromResolver(
        bytes memory target, // ERC-7930 Address
        bytes4 selector,
        bytes[] memory arguments, // Argument Encoding
        uint256[] memory dependencies // Steps by index in resolved order
    )
        external;
}

library Steps {
    function Call(
        bytes memory target, // ERC-7930 Interoperable Address
        bytes4 selector,
        bytes[] memory arguments, // Argument Encoding
        bytes[] memory attributes, // Attribute[] (Tagged Union Encoding)
        uint256[] memory dependencySteps, // Steps by index in resolved order
        bytes[] memory payments // Payment[] (Tagged Union Encoding)
    ) internal pure returns (bytes memory) {
        return abi.encodeCall(Step.Call, (target, selector, arguments, attributes, dependencySteps, payments));
    }
}
