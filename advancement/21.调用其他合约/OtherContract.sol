// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IOtherContract {
    function getBalance() external returns(uint);
    function setX(uint256 x) external payable;
    function getX() external view returns(uint x);
}

contract OtherContract is IOtherContract {
    uint256 private _x = 0; //  状态变量x
    //  收到eth事件，记录amount和gas
    event Log(uint amount, uint gas);

    //  返回合约ETH余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    //  可以调整状态变量_x的函数，并且可以往合约转ETH（payable）
    function setX(uint256 x) external payable {
        _x = x;

        if(msg.value > 0) {
            emit Log(msg.value, gasleft());
        }
    }

    //  读取x
    function getX() external view returns (uint x) {
        x = _x;
    }
} 


contract CallContract {
    function callSetX(address _Address, uint256 x) external {
        OtherContract(_Address).setX(x);
    }

    function callGetx(OtherContract _Address) external view returns (uint x) {
        x = _Address.getX();
    }

    function callGetX2(address _Address) external view returns (uint x) {
        OtherContract oc = OtherContract(_Address);
        x = oc.getX();
    }

    function callGetX3(address _Address) external view returns (uint x) {
        IOtherContract oc2 = IOtherContract(_Address);
        x = oc2.getX();
    }

    function setTransferETH(address otherContract, uint256 x) external payable {
        // OtherContract(otherContract).setX{value:msg.value}(x);
        OtherContract(otherContract).setX{value:100000000000000000}(x);
    } 
 
}

