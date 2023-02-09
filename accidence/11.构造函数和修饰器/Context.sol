// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    @dev 提供有关当前执行上下文的信息，包括事务的发送方及其数据。
    而这些通常可以通过 msg.sender 和 msg.data 获得，不应该以这种直接的方式访问它们，因为在处理元事务时，发送和支付执行的帐户可能不是实际的发送者(就应用程序而言)。
    此合约只适用于中间的类库合约。
*/
abstract contract Context {
    function _msgSender() internal view virtual returns(address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns(bytes calldata) {
        return msg.data;
    }
}
