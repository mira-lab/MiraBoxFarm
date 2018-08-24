pragma solidity ^0.4.19;

import './MiraFactory.sol';
import '../Buffer/Buffer.sol';
contract Template{
    function askOpen() view public returns (bool){}
}
contract PinSecretStorePermissions {
    
    address private owner;
    MiraFactory private miraFactory;
    Buffer private buffer;

    
    struct MiraBox{
        address contractAddress;
        bool opened;
    }
    
    mapping (bytes32 => MiraBox) miraboxes;


    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }
    
    function PinSecretStorePermissions(address factoryAddress) public {
        owner = msg.sender;
        miraFactory = MiraFactory(factoryAddress);
    }
    
    function setMiraBoxFactory(address newFactoryAddress) onlyOwner public{
        miraFactory = MiraFactory(newFactoryAddress);
    }

    function setBuffer(address newBufferAddress) onlyOwner public{
        buffer = Buffer(newBufferAddress);
    }
    
    function openMiraBox(bytes32 document) public returns (bool) {
        if(askContractOpen(document) && miraboxes[document].contractAddress != address(0)){
            miraboxes[document].opened = true;
        }
        return false;
    }

    function getMiraBoxOpened(bytes32 document) public view returns (bool) {
        return miraboxes[document].opened;
    }


    function addKey(bytes32 document, bytes32 templateName) public returns (bool) {
        require(miraboxes[document].contractAddress == address(0));
        bytes32 publicKey = buffer.giveKey();
        address contractAddress = miraFactory.createSmartOpener(templateName, document, msg.sender, publicKey);
        if(contractAddress != address(0)){
            miraboxes[document] = MiraBox({
            contractAddress:contractAddress,
            opened: false
            });
            return true;
        }
        return false;
    }
    
    function getMiraBoxContract(bytes32 document) public view returns (address) {
        return miraboxes[document].contractAddress;
    }
    
    function askContractOpen(bytes32 document) public view returns (bool){
        require(miraboxes[document].contractAddress != address(0));
        Template template = Template(miraboxes[document].contractAddress);
        return template.askOpen();
    }
    
    function checkPermissions(bytes32 document) public view returns (bool) {
         if(askContractOpen(document) && miraboxes[document].contractAddress != address(0)){
             return true;
         }
         return false;
    }
}
