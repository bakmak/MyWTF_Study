// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ERC20 is IERC20 {
    address private owner;

    mapping(address => uint256) public override balanceOf;     // 记录账户余额

    mapping(address => mapping(address => uint256)) public override allowance;  //记录授权额度

    uint256 public override totalSupply;    //  代币总供给

    string public name = "chick"; //  名称
    string public symbol = "CK";   //  代号

    uint8 public decimals = 18;     //  小数位数

    //  初始化部署者地址
    constructor() {
        owner = msg.sender;
    }

    //  实现IERC20中的transfer函数，代币转账逻辑。调用方扣除amount数量代币，接收方增加相应代币。
    function transfer(address recipient, uint amount) external override returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    //  实现IERC20中的approve函数，代币授权逻辑。被授权方spender可以支配授权方的amount数量的代币。
    //  spender可以是EOA账户，也可以是合约账户：当你用uniswap交易代币时，你需要将代币授权给uniswap合约。
    function approve(address spender, uint amount) external override returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    } 

    //  实现IERC20中的transferFrom函数，授权转账逻辑。被授权方将授权方sender的amount数量的代币转账给接收方recipient。
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external override returns (bool) {
        require(amount <= balanceOf[sender]);   
        require(amount <= allowance[sender][msg.sender]);

        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Approval(sender, recipient, amount);
        return true;
    }

    //  自毁合约
    function deleteContract() external {
        require(owner == msg.sender);
        selfdestruct(payable(msg.sender));
    }

    //  合约owner转移
    function changeOwner(address _newOwner) external {
        require(owner == msg.sender);
        owner = _newOwner;
    }

    //  铸造代币函数，任何人可以铸造任意数量的代币，实际应用中会加权限管理，只有owner可以铸造代币。
    function mint(uint amount) external {
        require(owner == msg.sender);
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    //  销毁代币函数，不在IERC20标准中。
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

}