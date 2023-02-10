// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

library Strings {
    bytes16 private constant _HEX_SYMBOLS = "0123456789abcdef";

    /**
     * @dev 将`uint256`转换为其ASCII `string`十进制表示形式。
     */
    function toString(uint256 value) public pure returns (string memory) {
        // 灵感来自OraclizeAPI的实现- MIT许可证
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    /**
     * @dev 将`uint256`转换为其ASCII `string`的十六进制表示形式。
     */
    function toHexString(uint256 value) public pure returns (string memory) {
        if (value == 0) {
            return "0x00";
        }
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length++;
            temp >>= 8;
        }
        return toHexString(value, length);
    }

    /**
     * @dev 将`uint256`转换为其ASCII `string`的固定长度的十六进制表示形式。
     */
    function toHexString(uint256 value, uint256 length) public pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _HEX_SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }
}


//  用函数调用另一个库合约
contract UseLibrary {
    //  利用using for 操作使用库
    using Strings for uint256;
    function getString1(uint256 _number) public pure returns (string memory) {
        //  库函数会自动添加为uint256类型变量的成员
        return _number.toHexString();
    }

    //  直接通过库合约名调用
    function getString2(uint _number) public pure returns (string memory) {
        return Strings.toHexString(_number);
    }

    function getToHexString(uint256 _number, uint256 _length) public pure returns (string memory) {
        return _number.toHexString(_length);
    }

    function getToDecString(uint256 _number) public pure returns (string memory) {
        return _number.toString();
    }
}