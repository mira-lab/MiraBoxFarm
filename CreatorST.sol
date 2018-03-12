pragma solidity ^0.4.4;

import 'browser/SimpleTime.sol';

library CreatorST {
    function create(address creator) returns (address)
    { return new SimpleTime(creator); }

    function version() constant returns (string)
    { return "v0.0.1"; }

    function abi() constant returns (string)
    { return "add abi when contract is ready"; }
}