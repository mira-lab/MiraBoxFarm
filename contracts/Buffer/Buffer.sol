pragma solidity ^0.4.23;

import './BufferInterface.sol';
import '../SmartFactory/MiraboxContract.sol';

contract Buffer is BufferInterface{
    
    address private owner;
    address private miraFactory;
    uint public keysCount = 0;
    uint public constant MAXKEYS = 100;
    
    mapping (uint => string) keysNumerator;
    mapping (address => bool) masterNodes;

    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }
    
    function setMiraFactory(address factoryAddress) onlyOwner public{
        miraFactory = factoryAddress;
    }
    
    function addMasterNode(address masterNode) onlyOwner public{
        masterNodes[masterNode] = true;
    }
    
    function addKey(string key) public returns (bool){
        if(((msg.sender == owner) || (masterNodes[msg.sender] == true)) && (keysCount <= MAXKEYS)){
            keysNumerator[keysCount] = key;
            keysCount++;
            return true;
        }else{
            return false;
        }
    }

    function isMasterNode(address _address) public view returns (bool){
        return(masterNodes[_address]);
    }
    
    function giveKey(address contractAddress) public returns(string){
        require(keysCount >= 1 && msg.sender == miraFactory);
        keysCount -= 1;
        string memory keyToGive = keysNumerator[keysCount];
        delete keysNumerator[keysCount];
        emit PublicKeyControlChange(keyToGive, contractAddress);
        MiraboxContract(contractAddress).setPublicKey(keyToGive);
        return keyToGive;
    }
    
    
}
