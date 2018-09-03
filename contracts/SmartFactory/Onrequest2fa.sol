pragma solidity ^0.4.18;

import '../Buffer/Buffer.sol';

contract Onrequest2fa is MiraboxContract{

    bool private isOpen = false;
    bool public confirmOpen2fa = true;
    bool public canChangeReceiver = true;

    string public receiver;
    string public publicKey = '';

    address private owner;
    address bufferAddress;
    address address2fa;

    Buffer buffer;

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

    function add2Fa(address _address2fa) public onlyOwner returns(bool){
        confirmOpen2fa = false;
        address2fa = _address2fa;
        return true;
    }

    function confirmOpen(string _receiver) public returns(bool){
        require(msg.sender == address2fa);
        if(keccak256(receiver) == keccak256(_receiver)){
            confirmOpen2fa = true;
            canChangeReceiver = false;
            return true;
        }else{
            return false;
        }
    }

    function changeReceiver(string newReceiver) public onlyOwner returns(bool){
        if(canChangeReceiver){
            receiver = newReceiver;
            emit UpdateReceiver(receiver);
            return true;
        }else{
            return false;
        }
    }

    function open() public returns(bool){
        if((msg.sender == owner) && confirmOpen2fa){
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
        require(buffer.isMasterNode(msg.sender) && isOpen);
        emit PrivateKey(_value);
        return _value;
    }

    function setPublicKey(string _publicKey) public returns (bool){
        require(msg.sender == bufferAddress);
        publicKey = _publicKey;
        return true;
    }
}
