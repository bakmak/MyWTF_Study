// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Address.sol)

pragma solidity ^0.8.0;

/**
 * @dev 与地址类型相关的函数集合
 */
library Address {
    /**
     * @dev 返回 true 如果 "账户" 是合约。
     *
     * [重要]
     * ====
     * 假设对于这个函数返回 false 的地址是外部拥有的账户（EOA）而不是合约是不安全的。
     *
     * 其中，isContract 将返回 false 的以下类型的地址：
     * 地址类型:
     *
     *  - 外部拥有的账户
     *  - 正在建设中的合约
     *  - 将创建合约的地址
     *  - 合约曾经存在过，但已经被销毁的地址
     * ====
     *
     * [重要]
     * ====
     * 你不应该依赖 isContract 来防止 flash loan 攻击！
     *
     * 防止从合约调用是高度不推荐的。它破坏了可组合性，破坏了对 Gnosis Safe 等智能钱包
     * 的支持，并且由于可以通过从合约构造函数调用来规避，因此不提供安全保障。
     * 
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // 这个方法依赖于 extcodesize，它在建造中的合约中返回 0，因为代码仅在构造函数执行结束时存储。

        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    /**
     * @dev 替代 Solidity 的“transfer”：将“amount” wei 发送到“recipient”，转发所有可用的 gas，在错误时回滚。
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] 增加了某些操作码的 gas 费用，
     * 可能使合约超过“transfer”强制执行的 2300 gas 限制，使它们无法通过“transfer”接收资
     * 金。{sendValue} 删除了这个限制。
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[了解更多].
     *
     * 重要提示：由于控制权转移到“recipient”，必须注意不创建重入漏洞。考虑使用 {ReentrancyGuard} 或
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[检查效果交互模式].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev 使用低级的 `call` 进行 Solidity 函数调用。
     * 一个纯粹的 `call` 是对函数调用的不安全替代方法：请使用此函数。
     * 
     *
     * 如果 `target` 带有回滚原因而回滚，则此函数会将其冒泡（就像普通的 Solidity 函数调用一样）。
     *
     * 返回原始返回数据。要转换为预期的返回值，请使用 
     *  https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * 要求:
     *
     * - `target` 必须是合约。
     * - 使用 `data` 调用 `target` 不得回滚。
     *
     * _自 v3.1 起可用。_
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev 与 {xref-Address-functionCall-address-bytes-}[`functionCall`] 相同，但当
     * `target` 恢复时使用 `errorMessage` 作为回退的原因。
     * 
     * _自从 v3.1 起可用。_
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev 与 {xref-Address-functionCall-address-bytes-}[`functionCall`] 相同，
     * 但也会将 `value` `wei` 转移到 `target`。
     *
     * 要求:
     *
     * - 调用合约必须至少拥有 `value` 的 ETH 余额。
     * - 被调用的 Solidity 函数必须是 `payable`。
     *
     * _自 v3.1 起可用。_
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev 与 {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`] 相同, 
     * 但当target回滚时，使用errorMessage作为回退原因。
     *
     * _自v3.1起可用。_
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev 与 {xref-Address-functionCall-address-bytes-}[`functionCall`] 相同,
     * 但执行静态调用。
     *
     * _自从 v3.3 起可用。_
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev 与 {xref-Address-functionCall-address-bytes-string-}[`functionCall`] 相同,
     * 但执行静态调用。
     *
     * _自 v3.3 起可用。_
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev 与 {xref-Address-functionCall-address-bytes-}[`functionCall`] 相同,
     * 但执行委托调用。
     *
     * _自v3.4起可用。_
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev 与 {xref-Address-functionCall-address-bytes-string-}[`functionCall`] 相同,
     * 但执行委托调用。
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev 验证低级别调用是否成功的工具，如果不成功，则使用提供的原因进行回滚。
     *
     * _自v4.3版本以来。_
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // 查找回滚原因，如果存在，则将其上升。
            if (returndata.length > 0) {
                // 使用 assembly 通过内存冒泡回滚原因的最简单方法

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}


contract AddressExample {
    //  利用using for 操作使用库
    using Address for address;

    function checkIfContanct(address _address) public view returns (bool) {
        return _address.isContract();
    }
}