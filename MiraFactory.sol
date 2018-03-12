pragma solidity ^0.4.18;
contract Builder{
    function getLastContract() constant returns (address) {}
    function create(address) public returns (address) {}
}
contract Template{
    function askOpen() view public returns (bool){}
}
contract MiraFactory{
    address public owner;
    mapping(bytes32 => address) public templates;
    mapping(bytes32 => address) public miraboxes;
    function MiraFactory() public{
        owner = msg.sender;
    }
    function convert(string key) returns (bytes32 ret) {
    if (bytes(key).length > 32) {throw;}
    assembly {
      ret := mload(add(key, 32))
    }
  }
    modifier onlyOwner { if (msg.sender != owner) throw; _; }
    
    
    function setOwner(address _owner) onlyOwner{
        owner = _owner;
    }
    
    function addTemplate(address _address, bytes32 _name) onlyOwner{
        templates[_name] = _address;
    }
    function createSmartOpener(bytes32 _name, bytes32 _documentid, address creator){
        address template = templates[_name];
        Builder template_contract = Builder(template);
        miraboxes[_documentid] = template_contract.create(creator);
    }
    function askOpen(bytes32 _documentid) returns (bool){
        Template _template = Template(miraboxes[_documentid]);
        return _template.askOpen();
    }
}