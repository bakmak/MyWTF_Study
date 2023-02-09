// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ValueType {

    bool public _bool = true;   //  布尔值

    //  布尔运算
    bool public _bool1 = !_bool;    //  取非
    bool public _bool2 = _bool && _bool1;   //  逻辑与
    bool public _bool3 = _bool || _bool1;   //  逻辑或
    bool public _bool4 = _bool == _bool1;   //  相等
    bool public _bool5 = _bool != _bool1;   //  不相等

    //  整型
    int public _int = -1;   //  整数，包括负数
    uint public _uint = 1;  //  正整数
    uint256 public _number = 20230207;  //  256位正整数

    //  整数运算
    uint256 public _number1 = _number + 1;  //  + - * /
    uint256 public _number2 = 2**2; //  指数
    uint256 public _number3 = 7 % 2;    //  取余数
    bool public _numberbool = _number2 > _number3;  //  比大小

    //  地址
    address public _address = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address payable public _address1 = payable(_address);   //  payable address，可以转账、查余额
    //  地址类型的成员
    uint256 public balance = _address1.balance; //  balance of address

    //  固定长度的字节数组
    bytes32 public _byte32 = "MiniSolidity";
    bytes1 public _byte = _byte32[0];

    //  用 enum 将 uint 0，1，2表示为Buy，Hold，Sell
    enum ActionSet {Buy, Hold, Sell}
    //  创建enum变量 action
    ActionSet action = ActionSet.Buy;

    //  enum可以和uint显式的转换
    function enumToUint() external view returns(uint) {
        return uint(action);
    }

}