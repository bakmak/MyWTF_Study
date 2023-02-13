// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Hash {
    bytes32 public _msg = keccak256(abi.encodePacked("0xAA"));
    bytes32 public _temp;

    //  唯一数字标识, keccak256哈希加密
    function hash(
        uint _num,
        string memory _string,
        address _addr
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_num, _string, _addr));
    }

    //  弱抗碰撞性
    function weak(
        string memory string1
    ) public returns (bool) {
        return (_temp = keccak256(abi.encodePacked(string1))) == _msg;
    }

    //  强抗碰撞性
    function strong(
        string memory string1, 
        string memory string2
    ) public pure returns (bool) {
        return keccak256(abi.encodePacked(string1)) == keccak256(abi.encodePacked(string2));
    }

}