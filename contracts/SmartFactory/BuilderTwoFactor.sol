pragma solidity ^0.4.18;

import './TwoFactor.sol';
contract BuilderTwoFactor{
    function create(address creator, address bufferAddress) public returns (address) {
        require(creator != address(0));
        address templateInstance =  new TwoFactor(creator, bufferAddress);
        return templateInstance;
    }
    function getName() public pure returns (bytes32){
        return "TwoFactor";
    }
    function getVersion() public pure returns (bytes32){
        return "0.0.1";
    }
    function getAuthor() public pure returns (bytes32){
        return "MiraLab";
    }
    function getAbi() public pure returns (string){
        return '[{"constant":true,"inputs":[],"name":"publicKey","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"canChangeReceiver","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"confirmOpen2fa","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"receiver","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[{"name":"creator","type":"address"},{"name":"_bufferAddress","type":"address"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"name":"_value","type":"string"}],"name":"PrivateKey","type":"event"},{"anonymous":false,"inputs":[],"name":"Open","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"receiver","type":"string"}],"name":"UpdateReceiver","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"contractAddress","type":"address"}],"name":"ContractCreated","type":"event"},{"constant":false,"inputs":[{"name":"newOwner","type":"address"}],"name":"changeOwner","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"askOpen","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_address2fa","type":"address"}],"name":"add2Fa","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_receiver","type":"string"}],"name":"confirmOpen","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"newReceiver","type":"string"}],"name":"changeReceiver","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"open","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"getPublicKey","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_value","type":"string"}],"name":"publishPrivateKey","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_publicKey","type":"string"}],"name":"setPublicKey","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"}]';
    }
    function getDescription() public pure returns (string){
        return "Can be opened only by assigned address or by owner, 2nd party can be added to confirm opening.";
    }
}
