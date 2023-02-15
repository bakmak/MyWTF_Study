// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./IERC20.sol";

contract ERC20 is IERC20 {

    mapping(address => uint256) public override balanceOf;

    mapping(address => mapping(address => uint256)) public override allowance;

    uint256 public override totalSupply;

    string public name;
    string public symbol;

    uint8 public decimals = 18;

    constructor(string memory name_, string memory symbol_) {
        name = name_;
        symbol = symbol_;
    } 

    function transfer(address recipient, uint amount) external override returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external override returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external override returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

}

//  ERC20代币的水龙头合约
contract Faucet {

    uint256 public amountAllowed = 100; //  每次领 100 单位代币
    address public tokenContract;   //  token 合约
    mapping(address => bool) public requestedAddress;   //  记录领取过代币的地址

    //  SendToken 事件
    event SendToken(address indexed Receiver, uint256 indexed Amount);

    //  部署时设定ERC20代币合约
    constructor(address _tokenContract) {
        tokenContract = _tokenContract;     //  设置token合约
    }

    //  用户领取代币函数
    function requestTokens() external {
        require(requestedAddress[msg.sender] == false, "Can't Request Multiple Times!"); // 每个地址只能领一次
        IERC20 token = IERC20(tokenContract);   //  创建 IERC20 合约对象
        require(token.balanceOf(address(this)) >= amountAllowed, "Faucet Empty!");  //  水龙头空了

        token.transfer(msg.sender, amountAllowed);  //  发送 token
        requestedAddress[msg.sender] = true;    //  记录领取地址

        emit SendToken(msg.sender, amountAllowed);  //  释放 SendToken 事件
    }

}