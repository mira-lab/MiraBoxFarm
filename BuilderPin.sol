pragma solidity ^0.4.18;

import 'browser/Pin.sol';
contract BuilderPin{
    function create(address creator) public returns (address) {
        require(creator != address(0));
        address templateInstance =  new Pin(creator);
        return templateInstance;
    }
    function getName() public pure returns (bytes32){
        return "Pin";
    }
    function getVersion() public pure returns (bytes32){
        return "0.0.1";
    }
    function getAuthor() public pure returns (bytes32){
        return "MiraLab";
    }
    function getAbi() public pure returns (string){
        return '[{"constant": false,"inputs": [{"name": "newPin","type": "bytes32"},{"name": "newOpenAddress","type": "address"}],"name": "setSettings","outputs": [],"payable": false,"stateMutability": "nonpayable","type": "function"},{"constant": true,"inputs": [],"name": "owner","outputs": [{"name": "","type": "address"}],"payable": false,"stateMutability": "view","type": "function"},{"constant": false,"inputs": [{"name": "_pin","type": "bytes32"}],"name": "open","outputs": [{"name": "","type": "bool"}],"payable": false,"stateMutability": "nonpayable","type": "function"},{"constant": true,"inputs": [],"name": "askOpen","outputs": [{"name": "","type": "bool"}],"payable": false,"stateMutability": "view","type": "function"},{"inputs": [{"name": "creator","type": "address"}],"payable": false,"stateMutability": "nonpayable","type": "constructor"}]';
    }
    function getDescription() public pure returns (string){
        return "Set pin by which MiraBox can be opened.";
    }
}
