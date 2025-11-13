// SPDX-License-Identifier: CC0
pragma solidity 0.8.30;

import {MandateOutput} from "../types/MandateOutput.sol";

interface IOutputSettler {
    function fill(bytes32 orderId, MandateOutput calldata output, uint48 fillDeadline, bytes calldata fillerData)
        external
        payable
        returns (bytes32 fillRecordHash);
}
