pragma solidity ^0.4.18;

contract MiraboxContract{

    event PrivateKey(string _value);
    event Open();
    event UpdateReceiver(string receiver);
    event ContractCreated(address indexed contractAddress);

    function changeOwner(address newOwner);

    function askOpen() public view returns (bool);

    function changeReceiver(string newReceiver) public returns(bool);

    function open() public returns(bool);

    function getPublicKey() public returns (string);

    function publishPrivateKey(string _value) public returns (string);

    function setPublicKey(string _publicKey) public returns (bool);
}