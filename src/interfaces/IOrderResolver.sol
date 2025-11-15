// SPDX-License-Identifier: CC0
pragma solidity 0.8.30;

import {ResolvedOrder} from "../types/ResolvedOrder.sol";

interface IOrderResolver {
    function resolve(bytes calldata payload) external view returns (ResolvedOrder memory);
}
