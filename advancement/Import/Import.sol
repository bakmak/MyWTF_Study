// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

//  通过文件相对位置import
// import './Yeye.sol';
//  通过`全局符号`导入特定的合约
import {Yeye} from './Yeye.sol';
//  通过Yeye重命名为Wow，后续代码中使用 Wow 来引用它
// import {Yeye as Wow}from"./Yeye.sol";
//  使用 as 关键字将从其他合约导入的接口、类型或变量重命名为我们自己的名字。这样可以避免名称冲突或使代码更易于阅读。
// import * as Wowo from "./Yeye.sol";
//  通过网址引用
import '@openzeppelin/contracts/utils/Address.sol';
//  引用openzeppelin合约
import '@openzeppelin/contracts/access/Ownable.sol';



contract Import {
    //  成功导入Address库
    using Address for address;
    //  声明yeye变量
    Yeye yeye = new Yeye();

    //  测试是否能调用yeye的函数
    function test() external {
        yeye.hip();
    }

    //  测试是否能调用isContract的函数
    function checkIfContanct(address _address) public view returns (bool) {
        return _address.isContract();
    }
}

