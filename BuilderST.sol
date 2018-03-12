pragma solidity ^0.4.18;

import 'browser/CreatorST.sol';
contract BuilderST{
    mapping(address => address[]) private getContractsOf;
    function getLastContract() constant returns (address) {
        var sender_contracts = getContractsOf[msg.sender];
        return sender_contracts[sender_contracts.length - 1];
    }
    function create(address creator) public returns (address) {
        address inst = CreatorST.create(creator);
        getContractsOf[msg.sender].push(inst);
        return inst;
    }
}