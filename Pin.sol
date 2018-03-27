pragma solidity ^0.4.18;

contract Pin{
    bytes32 private pin;
    bool private isOpen = false;
    address private openAddress;
    address public owner;
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    function Pin(address creator) public{
        owner = creator;
    }
    function askOpen() public view returns (bool){
        return isOpen;
    }
    function setSettings(bytes32 newPin, address newOpenAddress) public onlyOwner{
        require(newPin[0] != 0 && newOpenAddress != address(0));
        pin = newPin;
        openAddress = newOpenAddress;
    }
    function open(bytes32 _pin) public returns(bool){
        if(pin ==_pin && msg.sender == openAddress){
            isOpen = true;
            return true;
        }
        return false;
    }
}
