pragma solidity ^0.4.18;

import 'browser/SimpleTime.sol';
contract BuilderST{
    mapping(address => address[]) private getContractsOf;
    function getLastContract() constant returns (address) {
        var sender_contracts = getContractsOf[msg.sender];
        return sender_contracts[sender_contracts.length - 1];
    }
    function create(address creator) public returns (address) {
        require(creator != address(0));
        address templateInstance =  new SimpleTime(creator);
        return templateInstance;
    }
    function getName() public pure returns (bytes32){
        return "SimpleTime";
    }
    function getVersion() public pure returns (bytes32){
        return "0.0.1";
    }
    function getAuthor() public pure returns (bytes32){
        return "AuthorName";
    }
    function getDescription() public pure returns (string){
        return "Set time after which MiraBox can be opened.";
    }
}
