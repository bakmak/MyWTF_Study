// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Fallback {
/* 触发fallback() 还是 receive()?
           接收ETH
              |
         msg.data是空？
            /  \
          是    否
          /      \
receive()存在?   fallback()
        / \
       是  否
      /     \
receive()  fallback   
    */  

    //  定义事件
    event receivedCall(address Sender, uint Value, string message);
    // event fallbackCalled(address Sender, uint Value, bytes Data);

    //  接收ETH时释放receivedCall事件
    receive() external payable {
        emit receivedCall(msg.sender, msg.value, 'receive');
    } 

    // fallback() external payable {
    //     emit fallbackCalled(msg.sender, msg.value, msg.data);
    // }
}