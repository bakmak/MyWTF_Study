// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Pari {
    address public factory;     //  工厂合约地址
    address public token0;      //  代币0
    address public token1;      //  代币1

    constructor() payable {
        factory = msg.sender;
    }

    //  在部署时由工厂调用一次
    function initialize(address _token0, address _token1) external {
        require(msg.sender == factory, 'UniswapV2: FORBIDDEN'); //  足够的检查
        token0 = _token0;
        token1 = _token1;
    }
}


contract PariFactory {
    mapping(address => mapping(address => address)) public getPari; //  通过两个代币地址查Pari地址
    address[] public allPairs;  //  保存所有Pari地址

    function createPari(address tokenA, address tokenB) external returns (address pariAddr) {
        //  创建新合约
        Pari pari = new Pari();
        //  调用新合约的initialize方法
        pari.initialize(tokenA,tokenB);
        //  更新地址map
        pariAddr = address(pari);
        allPairs.push(pariAddr);
        getPari[tokenA][tokenB] = pariAddr;
        getPari[tokenB][tokenA] = pariAddr;
    }
}