// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/math/Math.sol)

pragma solidity ^0.8.0;

/**
 * @dev 标准数学工具缺少在 Solidity 语言中。
 */
library Math {
    /**
     * @dev 函数返回两个数字中最大的那个数。
     */
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a >= b ? a : b;
    }

    /**
     * @dev 返回两个数字中最小的那个。
     */
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }

    /**
     * @dev 返回两个数字的平均值，结果向零取整。
     */
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b) / 2 can overflow.
        return (a & b) + (a ^ b) / 2;
    }

    /**
     * @dev 返回两个数相除的结果的向上取整。
     *
     * 这与使用"/"进行标准除法不同，因为它向上取整而不是向下取整。
     */
    function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b - 1) / b can overflow on addition, so we distribute.
        return a / b + (a % b == 0 ? 0 : 1);
    }

    /**
     * @dev 返回一个有符号值的绝对无符号值。
     */
    function abs(int256 n) internal pure returns (uint256) {
        unchecked {
            // 必须不经过检查，以支持 n = type(int256).min。
            return uint256(n >= 0 ? n : -n);
        }
    }
}