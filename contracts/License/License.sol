pragma solidity ^0.4.24;

import 'openzeppelin-solidity/contracts/token/ERC20/MintableToken.sol';
import 'openzeppelin-solidity/contracts/token/ERC20/BurnableToken.sol';
contract PinSecretStorePermissions {
   function addKey(bytes32 document, bytes32 templateName) public returns (bool) {}
   function getMiraBoxContract(bytes32 document) public view returns (address) {}
}

contract License is MintableToken, BurnableToken {
    string public name = "License";
    string public symbol = "LIC";
    uint8 public decimals = 18;
    uint public miraboxPrice = 1;
    PinSecretStorePermissions private pinSecretStorePermissions;
    function changeMiraboxPrice(uint newPrice) onlyOwner public returns(bool){
      miraboxPrice = newPrice;
    }
    function setPSSP(address PSSPAddress) onlyOwner public{
      pinSecretStorePermissions = PinSecretStorePermissions(PSSPAddress);
    }
    function buyMirabox(bytes32 document, bytes32 templateName) public returns(address){
      require(miraboxPrice <= balanceOf(msg.sender));
      if(pinSecretStorePermissions.addKey(document, templateName)){
          _burn(msg.sender, miraboxPrice);
          return pinSecretStorePermissions.getMiraBoxContract(document);
      }else{
          revert('Error while creating mirabox!');
      }
    }
}