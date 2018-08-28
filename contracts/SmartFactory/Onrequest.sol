pragma solidity ^0.4.18;

import '../Buffer/Buffer.sol';

contract Onrequest{
    
    bool private isOpen = false;
    address private receiverAddress;
    address private owner;
    string public publicKey;
    Buffer buffer;

    event PrivateKey(string _value);
    event Open();
    event UpdateReciver(string _reciver);
    event ContractCreated(address contractAddress, string _publicKey);

    constructor (address creator, string _publicKey, address bufferAddress) public{
        owner = creator;
        publicKey = _publicKey;
        buffer = Buffer(bufferAddress);
        emit ContractCreated(address(this), _publicKey);
    }
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    function changeOwner(address newOwner) public onlyOwner{
        owner = newOwner;
    }
   
    function askOpen() public view returns (bool){
        return isOpen;
    }

    function setSettings(address newReceiverAddress) public onlyOwner{
        require(newReceiverAddress != address(0));
        receiverAddress = newReceiverAddress;
    }

    function open() public returns(bool){
        if(msg.sender == receiverAddress || msg.sender == owner){
            isOpen = true;
            emit Open();
            return true;
        }
        return false;
    }

    function getPublicKey() public returns (string){
        return publicKey;
    }

    function publishPrivateKey(string _value) returns (string)
    {
        require(buffer.isMasterNode(msg.sender));
        emit PrivateKey(_value);
        return _value;
    }
}
