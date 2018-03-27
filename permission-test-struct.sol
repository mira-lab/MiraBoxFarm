pragma solidity ^0.4.11;

contract MiraFactory{
    function askOpen(bytes32 _documentid) returns (bool){}
    function createSmartOpener(bytes32 name, bytes32 documentid, address creator) returns (address){}
}
contract Template{
    function askOpen() view public returns (bool){}
}
contract MiraboxesStorage{
    function setMiraboxContract(bytes32 document, address contractAddress) public{}
    function getMiraboxContract(bytes32 document) public view returns(address){}
}
contract PinSecretStorePermissions {
    address private _masterAdmin;
    MiraFactory private miraFactory;
    MiraboxesStorage private miraboxesStorage;
    
    struct SecretStoreKey {
        bytes32 documentId;
        address keyOwner;
        bool allowChangeOwner;
        bool opened;
    }
    mapping (uint => SecretStoreKey) secretStoreKeys;
    uint keysCount;

    modifier onlyOwner {
        require(_masterAdmin == msg.sender);
        _;
    }
    function PinSecretStorePermissions(address factoryAddress, address storageAddress) public {
        _masterAdmin = msg.sender;
        miraFactory = MiraFactory(factoryAddress);
        miraboxesStorage = MiraboxesStorage(storageAddress);
    }
    function setMiraBoxFactory(address newFactoryAddress) onlyOwner public{
        miraFactory = MiraFactory(newFactoryAddress);
    }
    function setMiraboxesStorage(address newStorageAddress) onlyOwner public{
        miraboxesStorage = MiraboxesStorage(newStorageAddress);
    }
    function openMiraBox(bytes32 document) public returns (bool) {
        for (uint i = 0; i < keysCount; i++) {
            if (secretStoreKeys[i].documentId == document) {
                if (secretStoreKeys[i].opened || (msg.sender != secretStoreKeys[i].keyOwner)) {
                    return false;
                }
                if(askOpen(document)){
                    secretStoreKeys[i].opened = true;
                    return true;
                }
            }
        }
        return false;
    }


    function getMiraBoxOpened(bytes32 document) public returns (bool) {
        for (uint i = 0; i < keysCount; i++) {
            if (secretStoreKeys[i].documentId == document) {
                return secretStoreKeys[i].opened;
            }
        }
        return false;
    }

    function changeOwner(bytes32 document, bytes32 setPin) public returns (bool) {
        for (uint i = 0; i < keysCount; i++) {
            if (secretStoreKeys[i].documentId == document) {
                if ((!secretStoreKeys[i].allowChangeOwner)) {
                    return false;
                }
                secretStoreKeys[i].allowChangeOwner = false;
                return true;
            }
        }
        return false;
    }


    function changeOwnerByAdmin(bytes32 document, address user, bool allowChangeOwner) public returns (bool) {
        if (msg.sender != _masterAdmin) {
            return false;
        }
        for (uint i = 0; i < keysCount; i++) {
            if (secretStoreKeys[i].documentId == document) {
                secretStoreKeys[i].keyOwner = user;
                secretStoreKeys[i].allowChangeOwner = allowChangeOwner;
                return true;
            }
        }
        return false;
    }


    function addKey(bytes32 document, bytes32 templateName) public returns (bool) {
        for (uint i = 0; i < keysCount; i++) {
            if (secretStoreKeys[i].documentId == document) {
                return false;
            }
        }
        secretStoreKeys[keysCount] = SecretStoreKey({
            documentId: document,
            keyOwner: msg.sender,
            allowChangeOwner: false,
            opened: false
        });
        keysCount = keysCount + 1;
        address contractAddress = miraFactory.createSmartOpener(templateName, document, msg.sender);
        if(contractAddress != address(0)){
            miraboxesStorage.setMiraboxContract(document, contractAddress);
            return true;
        }
        return false;
    }
    
    function askOpen(bytes32 documentid) public view returns (bool){
        require(documentid[0] != 0);
        address contractAddress = miraboxesStorage.getMiraboxContract(documentid);
        Template template = Template(contractAddress);
        return template.askOpen();
    }
    
    function checkKeyAccess(bytes32 document, address user) public returns (bool) {
        for (uint i = 0; i < keysCount; i++) {
            if (secretStoreKeys[i].documentId == document) {
                return (secretStoreKeys[i].keyOwner == user);
            }
        }
        return false;
    }


    function whoAccess(bytes32 document) public returns (address) {
        for (uint i = 0; i < keysCount; i++) {
            if (secretStoreKeys[i].documentId == document) {
                return secretStoreKeys[i].keyOwner;
            }
        }
        return 0;
    }


    function permittedCount(bytes32 document) public returns (uint256) {
        return keysCount;
    }


    function checkPermissions(bytes32 document) public view returns (bool) {
        for (uint i = 0; i < keysCount; i++) {
            if ((secretStoreKeys[i].documentId == document) && (askOpen(document))) {
                return true;
            }
        }
        return false;
    }
}
