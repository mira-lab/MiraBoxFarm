pragma solidity ^0.4.23;

contract Buffer{
    
    address private owner;
    address private smartFactory;
    uint private keysCount = 0;
    uint private constant MAXKEYS = 3000000;
    
    mapping (uint => bytes32) keysNumerator;
    mapping (address => bool) masterNodes;
    
    event PublicKeyControlChange(bytes32 publicKey);
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }
    
    function setFactory(address factoryAddress) onlyOwner public{
        smartFactory = factoryAddress;
    }
    
    function addMasterNode(address masterNode) onlyOwner public{
        masterNodes[masterNode] = true;
    }
    
    function addKey(bytes32 key) public returns (bool){
        if(((msg.sender == owner) || (masterNodes[msg.sender] == true)) && (keysCount <= MAXKEYS)){
            keysNumerator[keysCount] = key;
            keysCount++;
            return true;
        }else{
            return false;
        }
    }
    
    function giveKey() public returns(bytes32){
        require(keysCount >= 1 && msg.sender == smartFactory);
        keysCount -= 1;
        bytes32 keyToGive = keysNumerator[keysCount];
        delete keysNumerator[keysCount];
        emit PublicKeyControlChange(keyToGive);
        return keyToGive;
    }
    
    
}
