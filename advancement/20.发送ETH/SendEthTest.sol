// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

error CallFailed();

contract SendAndReceive {
    //  收到eth事件，记录amount和剩余gas
    event Log(uint amount, uint gas);
    //  构造函数，添加payable可以在部署的时候将ETH转入该合约
    // constructor() payable {}

    //  receive方法，接收eth时触发
    receive() external payable {
        emit Log(msg.value, gasleft());
    }

    //  call()发送ETH
    function callETH(address payable _to, uint256 amount) external payable {
        //  处理下call的返回值，如果失败，revert交易并发送error
        (bool success,) = _to.call{value: amount}("");
        if(!success) {
            revert CallFailed();
        }
    }

    // 返回合约ETH余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

}
