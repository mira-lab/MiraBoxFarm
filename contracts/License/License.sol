pragma solidity ^0.4.24;

import 'openzeppelin-solidity/contracts/token/ERC20/MintableToken.sol';
import 'openzeppelin-solidity/contracts/token/ERC20/BurnableToken.sol';
import '../SmartFactory/MiraFactory.sol';

contract License is MintableToken, BurnableToken {
    event PurchasedContract(address contractAddress, address owner);
    string public name = "License";
    string public symbol = "LIC";
    uint8 public decimals = 18;
    uint public miraboxPrice = 1;

    MiraFactory private miraFactory;

    function changeMiraboxPrice(uint newPrice) onlyOwner public returns(bool){
      miraboxPrice = newPrice;
    }

    function setMiraFactory(address factoryAddress) onlyOwner public{
      miraFactory = MiraFactory(factoryAddress);
    }

    function buyMirabox(bytes32 templateName) public returns(address){
      require(miraboxPrice <= balanceOf(msg.sender));
      address contractAddress = miraFactory.createMiraboxContract(templateName, msg.sender);
      if(contractAddress != address(0)){
        _burn(msg.sender, miraboxPrice);
	PurchasedContract(contractAddress, msg.sender);
        return contractAddress;
      }else{
        revert('Error while creating mirabox!');
      }
    }
}
