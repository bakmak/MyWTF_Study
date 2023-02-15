// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ChickFaucet {

    uint256 public constant  amountAllowed = 100;
    address public constant tokenContract = 0x5f3cAB415016777257A58b013e94Fed6334817a4;
    mapping(address => bool) public requestedAddress;

    event SendToken(address indexed Receiver, uint256 indexed Amount);

    function requestTokens() external {
        require(requestedAddress[msg.sender] == false, "Can't Request Multiple Times!");
        IERC20 token = IERC20(tokenContract);
        require(token.balanceOf(address(this)) >= amountAllowed, "Faucet Empty!");

        token.transfer(msg.sender, amountAllowed);
        requestedAddress[msg.sender] = true;

        emit SendToken(msg.sender, amountAllowed);
    }

}