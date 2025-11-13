// SPDX-License-Identifier: CC0
pragma solidity 0.8.30;

import {Assumption} from "./Assumption.sol";

struct ResolvedOrder {
    bytes[] steps; // Step[] (Tagged Union Encoding)
    bytes[] variables; // VariableRole[] (Tagged Union Encoding)
    Assumption[] assumptions;
    bytes[] payments;
}
