pragma solidity ^0.4.24;
contract BufferInterface{

     event PublicKeyControlChange(string indexed publicKey, address indexed contractAddress);

     function setMiraFactory(address factoryAddress);

     function addMasterNode(address masterNode);

     function addKey(string key) public returns (bool);

     function isMasterNode(address _address) public view returns (bool);

     function giveKey(address contractAddress) public returns(string);
}