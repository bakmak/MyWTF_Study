// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ChickAirdrop {

    address private constant token = 0x5f3cAB415016777257A58b013e94Fed6334817a4;

    function multiTransferToekn(
        address[] calldata _addresses,
        uint256[] calldata _amounts
    ) external {
        require(_addresses.length == _amounts.length, "Lengths of Addresses and Amounts NOT EQUAL");
        IERC20 _token = IERC20(token);
        uint _amountSum = getSum(_amounts);
        require(_token.allowance(msg.sender, address(this)) >= _amountSum, "Need Approve ERC20 token");
        for (uint8 i; i < _addresses.length; i++) {
            _token.transferFrom(msg.sender, _addresses[i], _amounts[i]);
        }
    }

    //  工具函数：数组求和
    function getSum(uint256[] calldata _arr) public pure returns (uint sum) {
        for(uint i = 0; i < _arr.length; i++) {
            sum = sum + _arr[i];
        }
    }

}