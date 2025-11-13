// SPDX-License-Identifier: CC0
pragma solidity 0.8.30;

import {IOutputSettler} from "./interfaces/IOutputSettler.sol";
import {Assumption} from "./types/Assumption.sol";
import {MandateOutput} from "./types/MandateOutput.sol";
import {ResolvedOrder} from "./types/ResolvedOrder.sol";
import {StandardOrder} from "./types/StandardOrder.sol";
import {Attributes} from "./libraries/Attributes.sol";
import {Formulas} from "./libraries/Formulas.sol";
import {InteroperableAddress} from "./libraries/InteroperableAddress.sol";
import {Payments} from "./libraries/Payments.sol";
import {Steps} from "./libraries/Steps.sol";

contract SliceOrderResolver {
    function resolve(bytes calldata payload) external view returns (ResolvedOrder memory resolvedOrder) {
        (StandardOrder memory order) = abi.decode(payload, (StandardOrder));

        bytes[] memory steps = new bytes[](2);
        bytes[] memory variables = new bytes[](1);
        Assumption[] memory assumptions = new Assumption[](0);
        bytes[] memory payments = new bytes[](0);

        MandateOutput memory output = order.outputs[0];
        {
            bytes32 orderId = keccak256(abi.encode(order));
            bytes[] memory fillArguments = new bytes[](4);
            {
                fillArguments[0] = abi.encode(orderId);
                fillArguments[1] = abi.encode(output);
                fillArguments[2] = abi.encode(order.fillDeadline);
                fillArguments[3] = abi.encode(abi.encode(0)); // filler's chosen recipient address
            }

            bytes[] memory attributes = new bytes[](2);
            {
                attributes[0] = Attributes.OnlyBefore(order.fillDeadline);
                attributes[1] = Attributes.SpendsERC20(
                    InteroperableAddress.formatEvmV1(output.chainId, address(bytes20(output.token))),
                    // TODO: We assume `output.amount` is a constant
                    Formulas.Const(output.amount),
                    // TODO: We assume `output.settler` is a known supported output settler
                    InteroperableAddress.formatEvmV1(output.chainId, address(bytes20(output.settler)))
                );
            }

            // 1. deposit in the compact
            // steps[0] =

            // 2. fill in the outputSettler
            steps[1] = Steps.Call(
                // TODO: we assume `chainId` is an EVM chain ID
                InteroperableAddress.formatEvmV1(output.chainId, address(bytes20(output.settler))),
                IOutputSettler.fill.selector,
                fillArguments,
                attributes,
                new uint256[](0), // TODO: `deposit` fn should be dependency?
                new bytes[](0)
            );

            // bytes[] memory payments = new
        }

        resolvedOrder = ResolvedOrder(steps, variables, assumptions, payments);
    }
}
