pragma solidity ^0.4.11;

contract MiraFactory{
    function askOpen(bytes32 _documentid) returns (bool){}
    function createSmartOpener(bytes32 name, bytes32 documentid, address creator) returns (address){}
}
contract PinSecretStorePermissions {
    address private _masterAdmin;
    MiraFactory miraFactory;
    
    struct SecretStoreKey {
        bytes32 documentId;
        address keyOwner;
        bytes32 pin;
        bool allowChangeOwner;
        bool opened;
    }

    
    mapping (uint => SecretStoreKey) secretStoreKeys;
    uint keysCount;


    function PinSecretStorePermissions(address factory) public {
        _masterAdmin = msg.sender;
        miraFactory = MiraFactory(factory);
    }
    function setMiraBoxFactory(address factory_address) public{
        require(_masterAdmin == msg.sender);
        miraFactory = MiraFactory(factory_address);
    }

    function openMiraBox(bytes32 document) public returns (bool) {
        for (uint i = 0; i < keysCount; i++) {
            if (secretStoreKeys[i].documentId == document) {
                if (secretStoreKeys[i].opened || (msg.sender != secretStoreKeys[i].keyOwner)) {
                    return false;
                }
                if(miraFactory.askOpen(document)){
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


    function changePin(bytes32 document, bytes32 oldPin, bytes32 newPin, bool allowChangeOwner) public returns (bool) {
        for (uint i = 0; i < keysCount; i++) {
            if (secretStoreKeys[i].documentId == document) {
                if ((msg.sender != secretStoreKeys[i].keyOwner) || (secretStoreKeys[i].pin != oldPin)) {
                    return false;
                }
                secretStoreKeys[i].pin = newPin;
                secretStoreKeys[i].allowChangeOwner = allowChangeOwner;
                return true;
            }
        }
        return false;
    }


    function changeOwner(bytes32 document, bytes32 accessPin, bytes32 setPin) public returns (bool) {
        for (uint i = 0; i < keysCount; i++) {
            if (secretStoreKeys[i].documentId == document) {
                if ((!secretStoreKeys[i].allowChangeOwner) || (secretStoreKeys[i].pin != accessPin)) {
                    return false;
                }
                secretStoreKeys[i].pin = setPin;
                secretStoreKeys[i].allowChangeOwner = false;
                return true;
            }
        }
        return false;
    }


    function changeOwnerByAdmin(bytes32 document, address user, bytes32 setPin, bool allowChangeOwner) public returns (bool) {
        if (msg.sender != _masterAdmin) {
            return false;
        }


        for (uint i = 0; i < keysCount; i++) {
            if (secretStoreKeys[i].documentId == document) {
                secretStoreKeys[i].keyOwner = user;
                secretStoreKeys[i].pin = setPin;
                secretStoreKeys[i].allowChangeOwner = allowChangeOwner;
                return true;
            }
        }
        return false;
    }


    function addKey(bytes32 document, address user, bytes32 pin, bytes32 templateName) public returns (address) {
        for (uint i = 0; i < keysCount; i++) {
            if (secretStoreKeys[i].documentId == document) {
                return address(0);
            }
        }
        secretStoreKeys[keysCount] = SecretStoreKey({
            documentId: document,
            keyOwner: user,
            pin: pin,
            allowChangeOwner: false,
            opened: false
        });
        keysCount = keysCount + 1;
        address miraboxHandler =  miraFactory.createSmartOpener(templateName, document, msg.sender);
        return miraboxHandler;
    }


    function checkKeyAccess(bytes32 document, address user, bytes32 pin) public returns (bool) {
        for (uint i = 0; i < keysCount; i++) {
            if (secretStoreKeys[i].documentId == document) {
                return (secretStoreKeys[i].keyOwner == user) && (secretStoreKeys[i].pin == pin);
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


    function checkPermissions(bytes32 document, address user) public constant returns (bool) {
        for (uint i = 0; i < keysCount; i++) {
            if ((secretStoreKeys[i].documentId == document) && (secretStoreKeys[i].keyOwner == user)) {
                return true;
            }
        }
        return false;
    }
}
