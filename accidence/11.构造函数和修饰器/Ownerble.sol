// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Context.sol";

/*
    @dev 合约模块，提供基本的访问控制机制，其中有一个帐户(所有者)可以被授予对特定功能的独占访问权。
    默认情况下，所有者帐户将是部署合约的帐户。稍后可以使用{transferOwnership}更改这一点。
    这个模块通过继承来使用。它将使修饰符' onlyowner '可用，它可以应用到你的函数中，以限制它们的使用。
*/

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    //  初始化合约，将部署人员设置为初始所有者。
    constructor() {
        _transferOwnership(_msgSender());
    }

    //  如果被所有者以外的任何帐户调用，则抛出。
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    //  返回当前所有者的地址。
    function owner() public view virtual returns (address) {
        return _owner;
    }

    //  如果发送者不是所有者，则抛出。
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    //  使合同没有所有者。再也不能调用' onlyOwner '函数了。只能由当前所有者调用。
    //  注意:放弃所有权将使合同失去所有者，从而删除了仅对所有者可用的任何功能。
    function renounceOwnership() public virtual onlyOwner() {
        _transferOwnership(address(0));
    }

    //  将合同的所有权转移到一个新帐户(' newOwner ')。只能由当前所有者调用。
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    //  将合同的所有权转移到一个新帐户(' newOwner ')。内部功能，不受访问限制。
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }

} 