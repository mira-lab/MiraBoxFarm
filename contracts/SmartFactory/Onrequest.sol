pragma solidity ^0.4.18;

import '../Buffer/Buffer.sol';

contract Onrequest is MiraboxContract{
    
    bool private isOpen = false;
    string public receiver;
    address private owner;
    string public publicKey = '';
    Buffer buffer;
    address bufferAddress;



    constructor (address creator, address _bufferAddress) public{
        owner = creator;
        bufferAddress = _bufferAddress;
        buffer = Buffer(bufferAddress);
        emit ContractCreated(address(this));
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

    function changeReceiver(string newReceiver) public onlyOwner returns(bool){
        receiver = newReceiver;
        emit UpdateReceiver(receiver);
        return true;
    }

    function open() public returns(bool){
        if(msg.sender == owner){
            isOpen = true;
            emit Open();
            return true;
        }
        return false;
    }

    function getPublicKey() public returns (string){
        return publicKey;
    }

    function publishPrivateKey(string _value) public returns (string)
    {
        require(buffer.isMasterNode(msg.sender));
        emit PrivateKey(_value);
        return _value;
    }

    function setPublicKey(string _publicKey) public returns (bool){
        require(msg.sender == bufferAddress);
        publicKey = _publicKey;
        return true;
    }
}
