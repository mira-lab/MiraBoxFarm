pragma solidity ^0.4.18;


contract Onrequest{
    
    bool private isOpen = false;
    address private openAddress;
    address private owner;
    bytes32 public publicKey;
    bytes32 private privateKey;
    constructor (address creator, bytes32 _publicKey) public{
        owner = creator;
        publicKey = _publicKey;
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
    function setSettings(address newOpenAddress) public onlyOwner{
        require(newOpenAddress != address(0));
        openAddress = newOpenAddress;
    }
    function open() public returns(bool){
        if(msg.sender == openAddress || msg.sender == owner){
            isOpen = true;
            return true;
        }
        return false;
    }
    function getPublicKey() public returns (bytes32){
        return publicKey;
    }
    function setPrivateKey(bytes32 _privateKey) public{
        privateKey = _privateKey;
    }
}
