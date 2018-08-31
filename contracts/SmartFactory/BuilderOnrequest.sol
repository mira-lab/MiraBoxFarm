pragma solidity ^0.4.18;

import './Onrequest.sol';
contract BuilderOnrequest{
    function create(address creator, address bufferAddress) public returns (address) {
        require(creator != address(0));
        address templateInstance =  new Onrequest(creator, bufferAddress);
        return templateInstance;
    }
    function getName() public pure returns (bytes32){
        return "Onrequest";
    }
    function getVersion() public pure returns (bytes32){
        return "0.0.1";
    }
    function getAuthor() public pure returns (bytes32){
        return "MiraLab";
    }
    function getAbi() public pure returns (string){
        return '[{"constant": false,"inputs": [{"name": "newOpenAddress","type": "address"}],"name": "setSettings","outputs": [],"payable": false,"stateMutability": "nonpayable","type": "function"},{"constant": false,"inputs": [{"name": "newOwner","type": "address"}],"name": "changeOwner","outputs": [],"payable": false,"stateMutability": "nonpayable","type": "function"},{"constant": true,"inputs": [],"name": "askOpen","outputs": [{"name": "","type": "bool"}],"payable": false,"stateMutability": "view","type": "function"},{"constant": false,"inputs": [],"name": "open","outputs": [{"name": "","type": "bool"}],"payable": false,"stateMutability": "nonpayable","type": "function"},{"inputs": [{"name": "creator","type": "address"}],"payable": false,"stateMutability": "nonpayable","type": "constructor"}]';
    }
    function getDescription() public pure returns (string){
        return "Can be opened only by assigned address or by owner.";
    }
}
