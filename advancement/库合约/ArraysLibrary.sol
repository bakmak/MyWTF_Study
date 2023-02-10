// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Arrays.sol)

pragma solidity ^0.8.0;

import "./Math.sol";

/**
 * @dev 这是一组与数组类型相关的函数。
 */
library Arrays {
    /**
     * @dev 在排序的数组array中搜索，并返回第一个包含大于或等于“元素”的值的索引。如
     * 果不存在这样的索引（即数组中的所有值都严格小于“元素”），则返回数组长度。时间复杂度
     * 为O（log n）。
     *
     * 预计数组按升序排列，并且不包含重复的元素。
     */
    function findUpperBound(uint256[] storage array, uint256 element) internal view returns (uint256) {
        if (array.length == 0) {
            return 0;
        }

        uint256 low = 0;
        uint256 high = array.length;

        while (low < high) {
            uint256 mid = Math.average(low, high);

            // 注意，mid 的值始终小于 high（也就是说，它将是一个有效的数组索引），因为 Math.average 向下取整（它执行截断的整数除法）。
            if (array[mid] > element) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }

        // 此时，low 是排除的上界。我们将返回包含的上界。
        if (low > 0 && array[low - 1] == element) {
            return low - 1;
        } else {
            return low;
        }
    }
}


// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.4.1/contracts/math/SafeMath.sol";

contract ArraysExample {
    using Arrays for uint256[];
    // using SafeMath for uint256;

    uint256[] public numbers;

    function addNumber(uint256 number) public {
        numbers.push(number);
    }

    // function removeNumber(uint256 index) public {
    //     numbers.removeAtIndex(index);
    // }

    function findUpperBound(uint256 element) public view returns (uint256) {
        return Arrays.findUpperBound(numbers, element);
    }
}
