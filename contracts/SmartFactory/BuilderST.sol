pragma solidity ^0.4.18;

import './SimpleTime.sol';
contract BuilderST{
    function create(address creator, bytes32 publicKey) public returns (address) {
        require(creator != address(0));
        address templateInstance =  new SimpleTime(creator, publicKey);
        return templateInstance;
    }
    function getName() public pure returns (bytes32){
        return "SimpleTime";
    }
    function getVersion() public pure returns (bytes32){
        return "0.0.1";
    }
    function getAuthor() public pure returns (bytes32){
        return "MiraLab";
    }
    function getAbi() public pure returns (string){
        return '[{"constant": true,"inputs": [],"name": "askNow","outputs": [{"name": "","type": "uint256"}],"payable": false,"stateMutability": "view","type": "function"},{"constant": false,"inputs": [{"name": "year","type": "uint16"},{"name": "month","type": "uint8"},{"name": "day","type": "uint8"},{"name": "hour","type": "uint8"},{"name": "minute","type": "uint8"},{"name": "second","type": "uint8"}],"name": "setSettings","outputs": [],"payable": false,"stateMutability": "nonpayable","type": "function"},{"constant": true,"inputs": [],"name": "getSettings","outputs": [{"name": "","type": "uint256"}],"payable": false,"stateMutability": "view","type": "function"},{"constant": true,"inputs": [],"name": "owner","outputs": [{"name": "","type": "address"}],"payable": false,"stateMutability": "view","type": "function"},{"constant": true,"inputs": [],"name": "askOpen","outputs": [{"name": "","type": "bool"}],"payable": false,"stateMutability": "view","type": "function"},{"constant": true,"inputs": [],"name": "timeToOpen","outputs": [{"name": "","type": "uint256"}],"payable": false,"stateMutability": "view","type": "function"},{"inputs": [{"name": "creator","type": "address"}],"payable": false,"stateMutability": "nonpayable","type": "constructor"}]';
    }
    function getDescription() public pure returns (string){
        return "Set time and date after which MiraBox can be opened.";
    }
}
