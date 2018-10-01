pragma solidity ^0.4.18;

import "./strings.sol";
import '../Buffer/Buffer.sol';

contract Builder{
    function create(address, address) public returns (address) {}
    function getName() public pure returns (bytes32){}
    function getVersion() public pure returns (bytes32){}
    function getAuthor() public pure returns (bytes32){}
}

contract MiraFactory{
    using strings for *;
    
    address public owner;
    address public licenseAddress;
    address public bufferAddress;
    mapping(bytes32 => address) public templates;
    
    string public templatesList;
    bool private firstTemplate = true;

    Buffer private buffer;


    function MiraFactory() public{
        owner = msg.sender;
        templatesList = '{"templates": []}';
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    modifier onlyLicense {
        require(msg.sender == licenseAddress);
        _;
    }

    function setLicenseContract(address _licenseAddress) public onlyOwner {
        licenseAddress = _licenseAddress;
    }

    function setBuffer(address _bufferAddress) onlyOwner public{
        bufferAddress = _bufferAddress;
        buffer = Buffer(_bufferAddress);
    }
    
    function setOwner(address _owner) public onlyOwner{
        require(_owner != address(0));
        owner = _owner;
    }

    function bytes32ToString(bytes32 x) private pure returns (string) {
        bytes memory bytesString = new bytes(32);
        uint charCount = 0;
        for (uint j = 0; j < 32; j++) {
            byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }
        bytes memory bytesStringTrimmed = new bytes(charCount);
        for (j = 0; j < charCount; j++) {
            bytesStringTrimmed[j] = bytesString[j];
        }
        return string(bytesStringTrimmed);
    }
    
    function toAsciiString(address x) pure private returns (string) {
        bytes memory s = new bytes(40);
        for (uint i = 0; i < 20; i++) {
            byte b = byte(uint8(uint(x) / (2**(8*(19 - i)))));
            byte hi = byte(uint8(b) / 16);
            byte lo = byte(uint8(b) - 16 * uint8(hi));
            s[2*i] = char(hi);
            s[2*i+1] = char(lo);            
        }
        return string(s);
    }

    function char(byte b) pure private returns (byte c) {
        if (b < 10) return byte(uint8(b) + 0x30);
        else return byte(uint8(b) + 0x57);
    }
    
    function addTemplate(address templateAddress) public onlyOwner returns(bool){
        require(templateAddress != address(0)); 
        Builder template = Builder(templateAddress);
        if(templates[template.getName()] != address(0))
            return false;
        templates[template.getName()] = templateAddress;
        addToTemplatesList(template);
        return true;
    }
    
    function addToTemplatesList(Builder template) private{
        string memory name = bytes32ToString(template.getName());
        string memory version = bytes32ToString(template.getVersion());
        string memory author =  bytes32ToString(template.getAuthor());
        string memory _address = toAsciiString(templates[template.getName()]);
        if(firstTemplate){
            var newContent = '{"name": "'.toSlice().concat(name.toSlice());
            firstTemplate = false;
        }else{
            newContent = ', {"name": "'.toSlice().concat(name.toSlice());
        }
        newContent = newContent.toSlice().concat('","version": "'.toSlice());
        newContent = newContent.toSlice().concat(version.toSlice());
        newContent = newContent.toSlice().concat('","author": "'.toSlice());
        newContent = newContent.toSlice().concat(author.toSlice());
        newContent = newContent.toSlice().concat('","address": "0x'.toSlice());
        newContent = newContent.toSlice().concat(_address.toSlice());
        newContent = newContent.toSlice().concat('"}]}'.toSlice());
        var prevContent = templatesList.toSlice();
        prevContent.until("]}".toSlice());
        templatesList =  prevContent.concat(newContent.toSlice());
    }
    
    function getTemplatesList() public view returns(string){
        return templatesList;
    }

    
    function createMiraboxContract(bytes32 templateName, address creator) public onlyLicense returns(address){
        require(templateName[0] != 0 &&
                templates[templateName] != address(0));
        Builder templateInstance = Builder(templates[templateName]);
        address miraboxContract = templateInstance.create(creator, bufferAddress);
        if(miraboxContract == address(0)){
            revert('Cant create mirabox contract!');
            return address(0);
        }
        buffer.giveKey(miraboxContract);
        return miraboxContract;
    }
}
