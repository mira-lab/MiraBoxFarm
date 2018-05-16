pragma solidity ^0.4.18;

contract MiraboxesStorage{
    address private owner;
    address private aclAddress;
    mapping(bytes32 => address) private miraboxes;
    function MiraboxesStorage() public{
        owner = msg.sender;
    }
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    modifier onlyACL {
        require(msg.sender == aclAddress);
        _;
    }
    function setACL(address newAclAddress) public onlyOwner{
        require(newAclAddress != address(0));
        aclAddress = newAclAddress;
    }
    function changeOwner(address newOwner) public onlyOwner{
        require(newOwner != address(0));
        owner = newOwner;
    }
    function setMiraboxContract(bytes32 document, address contractAddress) public{
        require(contractAddress != address(0) && document[0] != 0 && miraboxes[document] == address(0));
        miraboxes[document] = contractAddress;
    }
    function getMiraboxContract(bytes32 document) public view returns(address){
        require(document[0] != 0 && miraboxes[document] != address(0));
        return miraboxes[document];
    }
}
