// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract InitialValue {
    //  Value Types
    bool public _bool;  //  false
    string public _string;  //  ""
    int public _int;    //  0
    uint public _uint;  //  0
    address public _address;    //  0x0000000000000000000000000000000000000000 (或 address(0))
    bytes public _bytes;
    bytes1 public _bytes1;

    enum ActionSet { Buy, Hold, Sell}
    ActionSet public _enum; //  第一个元素 0

    function fi() internal {}   //  internal空白工程
    function fe() external {}   //  external空白工程

    //  Reference Type
    uint[8] public _staticArray;    //  所有成员设为其默认值的静态数组[0,0,0,0,0,0,0,0]
    uint[] public _dynamicArray;    //  `[]`
    mapping(uint => address) public _mapping;   //  所有元素都为其默认值的mapping
    //  所有成员设为其默认值的结构体 0，0
    struct Student{
        uint256 id;
        uint256 score;
    }
    Student public student;

    //  delete操作符
    bool public _bool2 = true;
    function d() external {
        delete _bool2;  //  delete 会让_bool2变为默认值，false
    }

}

contract DeleteTest {
    //  delete操作符
    bool public _bool2 = true;
    
    address public _address = address(1);

    enum ActionSet { Buy, Hold, Sell}
    ActionSet public _enum = ActionSet.Buy;

    struct Student{
        uint256 id;
        uint256 score;
    }
    Student public student = Student(10, 225); 
    
    uint[8] public _staticArray = [1,2,3,4,5,6,7,8];

    function d_bool() external {
        delete _bool2;  //  delete 会让_bool2变为默认值，false
    }

    function d_address() external {
        delete _address;  //  delete 会让_address变为默认值，address(0)
    }

    function d_enum() external {
        delete _enum;   //  delete 会让_enum变为默认值，第一个枚举值Buy的下标 0
    }

    function d_student() external {
        delete student; //  delete 会让student变为默认值，student(0, 0)
    }

    function d_staticArray() external {
        delete _staticArray;    //  delete 会让_staticArray变为默认值，[0,0,0,0,0,0,0,0]
    }

}
