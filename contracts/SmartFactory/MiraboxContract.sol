pragma solidity ^0.4.24;

contract MiraboxContract{

    event PrivateKey(string _value);
    event Open();
    event UpdateReceiver(address _receiver);
    event ContractCreated(address contractAddress);

    function changeOwner(address newOwner);

    function askOpen() public view returns (bool);

    function changeReceiver(address newReceiverAddress) public returns (bool);

    function open() public returns(bool);

    function getPublicKey() public returns (string);

    function publishPrivateKey(string _value) public returns (string);

    function setPublicKey(string _publicKey) public returns (bool);
}