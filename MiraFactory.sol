pragma solidity ^0.4.18;
import "github.com/Arachnid/solidity-stringutils/strings.sol";
contract Builder{
    using strings for *;
    function getLastContract() constant returns (address) {}
    function create(address) public returns (address) {}
    function getName() public pure returns (bytes32){}
    function getVersion() public pure returns (bytes32){}
    function getAuthor() public pure returns (bytes32){}
}
contract Template{
    function askOpen() view public returns (bool){}
}
contract MiraFactory{
    using strings for *;
    address public owner;
    address private acl;
    mapping(bytes32 => address) public templates;
    mapping(bytes32 => address) public miraboxes;
    string public templatesList;
    bool private firstTemplate = true;
    function MiraFactory() public{
        owner = msg.sender;
        templatesList = '{"templates": []}';
    }
    function bytes32ToString(bytes32 x) internal constant returns (string) {
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
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    modifier onlyACL{
        require(acl != address(0) && msg.sender == acl);
        _;
    }
    function setOwner(address _owner) public onlyOwner{
        require(_owner != address(0));
        owner = _owner;
    }
    function setACLcontract(address _acl) public onlyOwner{
        acl = _acl;
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
        newContent = newContent.toSlice().concat('"}]}'.toSlice());
        var prevContent = templatesList.toSlice();
        prevContent.until("]}".toSlice());
        templatesList =  prevContent.concat(newContent.toSlice());
    }
    function getTemplatesList() public view returns(string){
        return templatesList;
    }
    function createSmartOpener(bytes32 name, bytes32 documentid, address creator) public onlyACL returns(address){
        require(name[0]!=0 && 
            documentid[0]!= 0 && 
            creator!=address(0) &&
            templates[name] != address(0));
        Builder templateInstance = Builder(templates[name]);
        miraboxes[documentid] = templateInstance.create(creator);
        return miraboxes[documentid];
    }
    function askOpen(bytes32 documentid) onlyACL public returns (bool){
        require(documentid[0] != 0 && miraboxes[documentid] != address(0));
        Template template = Template(miraboxes[documentid]);
        return template.askOpen();
    }
}
