// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/*
该合约实现了代币的转移，代币的查询，以及授权某个地址可以转移代币的功能。
通过内置的 Balances 库，实现了代币地址之间的转移。
该合约使用了 Transfer 和 Approval 事件来记录代币的转移和授权情况。
*/

library Balances {
    //  该内部函数用于在两个账户之间转移资金。
    //  它需要一个存储映射类型的参数 balances，表示各个地址的余额。
    //  还需要两个地址 from 和 to，以及一个整数量 amount。
    //  此函数将从 from 账户中扣除 amount，并向 to 账户添加 amount。
    //  如果 from 账户的余额小于 amount，则操作将被终止。
    function send(mapping(address => uint256) storage balances, 
    address from, address to, uint amount) internal {
        require(balances[from] >= amount);
        require(balances[to] + amount >= balances[to]);
        balances[from] -= amount;
        balances[to] += amount;
    } 
}

contract Token {
    mapping(address => uint256) balances;
    using Balances for *;
    mapping(address => mapping(address => uint256)) allowed;

    event Transfer(address from, address to, uint amount);
    event Approval(address owner, address spender, uint amount);

    //  该函数的目的是返回某个地址的Token余额。
    function balanceOf(address tokenOwner) public returns (uint balance) {
        return balances[tokenOwner];
    }

    //  该函数用于从发送者的地址转移Token到接收者的地址。
    //  to 接收者地址       amount 要转移的Token数量
    function transfer(address to, uint amount) public returns (bool success) {
        balances.send(msg.sender, to, amount);
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    //  该函数用于从一个地址转移token到另一个地址。
    //  from 转移的起始地址     to 转移的目的地址       amount 要转移的token数量。
    function transferFrom(address from, address to, uint amount) public returns (bool success) {
        require(allowed[from][msg.sender] >= amount);
        allowed[from][msg.sender] -= amount;
        balances.send(from, to, amount);
        emit Transfer(from, to, amount);
        return true;
    } 

    //  该函数用于批准某个地址可以从发送者的地址转移一定数量的token。
    //  spender 是接收token的地址       tokens 是token转移的数量
    function approve(address spender, uint tokens) public returns (bool success) {
        require(allowed[msg.sender][spender] == 0, "");
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

}