// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract OtherContract {
    uint256 private _x = 0;     //  状态变量
    event Log(uint amount, uint gas);   //  // 收到eth事件，记录amount和gas

    // fallback() external payable {}

    //  返回合约ETH余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // 可以调整状态变量_x的函数，并且可以往合约转ETH (payable)
    function setX(uint256 x) external payable {
        _x = x;
        if(msg.value > 0) {     // 如果转入ETH，则释放Log事件
            emit Log(msg.value, gasleft());
        }
    }

    //  读取x
    function getX() external view returns (uint x) {
        x = _x;
    }

}


contract Call {
    //  定义Response事件，输出call返回的结果success和data
    event Ressponse(bool success, bytes data);

    function callSetX(address payable _addr, uint256 x) public payable {
        //  call setX()，同时可以发送ETH
        (bool success, bytes memory data) = _addr.call{value:msg.value}(
            abi.encodeWithSignature("setX(uint256)",x)
        );

        emit Ressponse(success, data);  //  释放事件
    }

    function callGetX(address _addr) external returns (uint256) {
        //  call getX()
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("getX()")
        );

        emit Ressponse(success, data);
        return abi.decode(data, (uint256));
    }

    function callNonExist(address _addr) external {
        //  call getX()
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("foo(uint256)")
        );

        emit Ressponse(success, data);  //  释放事件
    }

    function callSetX1(address payable nameReg, uint256 x) public payable {
        //  call setX()，同时可以发送ETH
        // (bool success, bytes memory data) = _addr.call{value:msg.value}(
        //     abi.encodeWithSignature("setX(uint256)",x)
        // );
        // (bool success, bytes memory data) = address(nameReg).call{gas: 1000000}(
        //     abi.encodeWithSignature("setX(uint256)", "MyName")
        //     );
        (bool success, bytes memory data) = address(nameReg).call{value: 1 ether}(
            abi.encodeWithSignature("setX(uint256)", x)
        );
        emit Ressponse(success, data);  //  释放事件
    }

}