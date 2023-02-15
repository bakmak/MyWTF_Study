// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Airdrop {

    //  @notice 向多个地址转账 ERC20 代币，使用前需要先授权
    //  @param  _token 转账的 ERC20 代币地址
    //  @param  _addresses  空投地址数组
    //  @param  _amounts    代币数量数组（每个地址的空投数量）
    function multiTransferToekn(
        address _token,
        address[] calldata _addresses,
        uint256[] calldata _amounts
    ) external {
        //  检查：_addresses和_amounts数组的长度相等
        require(_addresses.length == _amounts.length, "Lengths of Addresses and Amounts NOT EQUAL");
        IERC20 token = IERC20(_token);  //  声明 IERC20 合约变量
        uint _amountSum = getSum(_amounts); //  计算空投代币总量
        //  检查：授权代币数量 >= 空投代币总量
        require(token.allowance(msg.sender, address(this)) >= _amountSum, "Need Approve ERC20 token");

        //  for循环，利用 transferFrom 函数发送空投
        for(uint8 i; i < _addresses.length; i++) {
            token.transferFrom(msg.sender, _addresses[i], _amounts[i]);
        }
    }

    //  向多个地址转账ETH
    function multiTransferETH(
        address payable[] calldata _address,
        uint256[] calldata _amounts
    ) public payable {
        //  检查：_addresses 和 _amounts 数组的长度相等
        require(_address.length == _amounts.length, "Lengths of Addresses and Amounts NOT EQUAL");
        uint _amountSum = getSum(_amounts); //  计算空投ETH总量
        
        //  for循环，利用 transferFrom 函数发送 ETH
        for(uint8 i; i < _address.length; i++) {
            _address[i].transfer(_amounts[i]);
        }
    }

    //  数组求和函数
    function getSum(uint256[] calldata _arr) public returns (uint sum) {
        for(uint i = 0; i < _arr.length; i++) {
            sum = sum + _arr[i];
        }
    }

}

