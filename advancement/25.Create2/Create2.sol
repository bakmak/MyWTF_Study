// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Pari {
    address public factory;    //   工厂合约地址
    address public token0;      //  代币1
    address public token1;      //  代币2

    constructor() payable {
        factory = msg.sender;
    }
    //  在部署时由工厂调用一次
    function initialize(address _token0, address _token1) external {
        require(msg.sender == factory, 'UniswapV2: FORBIDDEN');
        token0 = _token0;
        token1 = _token1;
    }
}


contract PariFactory {
    mapping(address => mapping(address => address)) public getPari; //  通过两个代币地址查Pair地址
    address[] public allPairs;  //  保存所有Pair地址

    function createPari2(address tokenA, address tokenB) external returns (address pariAddr) {
        require(tokenA != tokenB, 'IDENTICAL_ADDRESSES'); //    避免tokenA和tokenB相同产生的冲突
        //  计算用tokenA和tokenB地址计算salt
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        //  用create2部署新合约
        Pari pari = new Pari{salt: salt}();
        //  调用新合约的initialize方法
        pari.initialize(tokenA, tokenB);
        //  更新地址map
        pariAddr = address(pari);
        allPairs.push(pariAddr);
        getPari[tokenA][tokenB] = pariAddr;
        getPari[tokenB][tokenA] = pariAddr;
    }

    //  提前计算pair合约地址
    function calculateAddr(address tokenA, address tokenB) public view returns (address predictedAddress) {
        require(tokenA != tokenB, 'IDENTICAL_ADDRESSES'); //    避免tokenA和tokenB相同产生的冲突
        //  计算用tokenA和tokenB地址计算salt
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        //  计算合约地址方法 hash()
        predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            keccak256(type(Pari).creationCode)
        )))));
    }
}