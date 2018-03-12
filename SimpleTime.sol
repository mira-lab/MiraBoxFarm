pragma solidity ^0.4.18;

import 'browser/DateTime.sol';

contract SimpleTime{
    uint public timeToOpen;
    address public owner;
    bool canOpen = false;
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    function SimpleTime(address creator) public{
        owner = creator;
    }
    function askOpen() view public returns (bool){
        if(timeToOpen >= now){
            canOpen = true;
        }
        return canOpen;
    }
    function askNow() view public returns(uint){
        return now;
    }
    function setSettings(uint16 year, uint8 month, uint8 day, uint8 hour, uint8 minute, uint8 second) public onlyOwner{
        address datetime_address = new DateTime();
        DateTime datetime_instance = DateTime(datetime_address);
        timeToOpen = datetime_instance.toTimestamp(year, month, day, hour, minute, second);
    }
    function getSettings() view public returns(uint){
        return timeToOpen;
    }
}