// SPDX-License-Identifier: CC0
pragma solidity 0.8.30;

interface Payment {
    function ERC20(
        bytes memory token, // ERC-7930 Address
        bytes memory amountFormula, // Formula (Tagged Union Encoding)
        uint256 recipientVarIdx,
        uint256 estimatedDelaySeconds
    ) external;
}

library Payments {
    function ERC20(
        bytes memory token, // ERC-7930 Address
        bytes memory amountFormula, // Formula (Tagged Union Encoding)
        uint256 recipientVarIdx,
        uint256 estimatedDelaySeconds
    ) internal pure returns (bytes memory) {
        return abi.encodeCall(Payment.ERC20, (token, amountFormula, recipientVarIdx, estimatedDelaySeconds));
    }
}
