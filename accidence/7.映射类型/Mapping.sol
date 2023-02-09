// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Mapping {
    mapping(uint => address) public idToMapping; // id映射到地址
    mapping(address => address) public swapPair; // 币对的映射，地址到地址

        //  规则1. _KeyType不能是自定义的，下面这个例子就会报错
        //  我们定义一个结构体 struct
//     struct Student{
//         uint256 id;
//         uint256 score;
//     }
//     mapping(Student => uint) public testVar;

    function writeMap(uint _Key, address _Value) public {
        idToMapping[_Key] = _Value;
    }

}