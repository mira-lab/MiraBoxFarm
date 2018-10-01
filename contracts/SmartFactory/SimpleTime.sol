pragma solidity ^0.4.18;

import './DateTime.sol';

contract SimpleTime{
    uint public timeToOpen;
    bytes32 publicKey;
    address public owner;
    bytes32 private privateKey;
    DateTime private datetimeInstance;
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    function SimpleTime(address creator, bytes32 _publicKey) public{
        owner = creator;
        publicKey = _publicKey;
        address datetimeAddress = new DateTime();
        datetimeInstance = DateTime(datetimeAddress);
    }
    function askOpen() public view returns (bool){
        if(now >= timeToOpen && timeToOpen != 0){
            return true;
        }
        return false;
    }
    function askNow() view public returns(uint){
        return now;
    }
    function setSettings(uint16 year, uint8 month, uint8 day, uint8 hour, uint8 minute, uint8 second) public onlyOwner{
        timeToOpen = datetimeInstance.toTimestamp(year, month, day, hour, minute, second);
    }
    function getSettings() view public returns(uint){
        return timeToOpen;
    }
    function getPublicKey() public returns (bytes32){
        return publicKey;
    }
    function setPrivateKey(bytes32 _privateKey) public{
        privateKey = _privateKey;
    }
}
