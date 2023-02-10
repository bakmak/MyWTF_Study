// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Create2.sol)

pragma solidity ^0.8.0;

/**
 * @dev 帮助更容易和更安全地使用 CREATE2 EVM 操作码的助手。
 * `CREATE2` 可用于提前计算智能合约将被部署的地址，这允许使用称为“反事实交互”的有
 * 趣新机制。
 *
 * 有关更多信息，请参见 https://eips.ethereum.org/EIPS/eip-1014#motivation[EIP] 
 * 
 */
library Create2 {
    /**
     * @dev 通过使用 “CREATE2” 部署合约。合约的部署地址可以通过 {computeAddress} 提前知道。
     *
     * 可以通过 Solidity 的 “type(contractName).creationCode” 获取合约的字节码。
     *
     * 要求:
     *
     * - “bytecode” 不能为空。
     * - “salt” 必须不能已经用于 “bytecode”。
     * - 工厂必须具有至少 “amount” 的余额。
     * - 如果 “amount” 不为零，则 “bytecode” 必须具有 “payable” 构造函数。
     */
    function deploy(
        uint256 amount,
        bytes32 salt,
        bytes memory bytecode
    ) internal returns (address) {
        address addr;
        require(address(this).balance >= amount, "Create2: insufficient balance");
        require(bytecode.length != 0, "Create2: bytecode length is zero");
        assembly {
            addr := create2(amount, add(bytecode, 0x20), mload(bytecode), salt)
        }
        require(addr != address(0), "Create2: Failed on deploy");
        return addr;
    }

    /**
     * @dev 返回合约将在通过{deploy}部署存储的地址。`bytecodeHash` 或 `salt`的任何更改都将导致新的目标地址。
     * 
     */
    function computeAddress(bytes32 salt, bytes32 bytecodeHash) internal view returns (address) {
        return computeAddress(salt, bytecodeHash, address(this));
    }

    /**
     * @dev 返回如果通过位于deployer处的合约部署{deploy}，将存储合约的地址。
     * 如果deployer是此合约的地址，则返回与{computeAddress}相同的值。
     */
    function computeAddress(
        bytes32 salt,
        bytes32 bytecodeHash,
        address deployer
    ) internal pure returns (address) {
        bytes32 _data = keccak256(abi.encodePacked(bytes1(0xff), deployer, salt, bytecodeHash));
        return address(uint160(uint256(_data)));
    }
}


contract Create2Example {
    using Create2 for *;

    address public newContract;

    constructor() public {
        bytes32 salt = keccak256(abi.encodePacked("randomSalt"));
        bytes memory bytecode = abi.encodeWithSignature("deployFunction(uint256)", 256);
        newContract = Create2.deploy(0, salt, bytecode);
    }
}