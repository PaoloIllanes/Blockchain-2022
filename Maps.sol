// SPDX-License-Identifier:GPL-3.0
pragma solidity 0.8.0;
contract Maps{

    bool public myBoolean;
    string public myString;
    uint public myNumber;
    mapping(uint =>bool) public myMappping;
    mapping(address =>uint) public myAdresses;

    function setValue(uint index, bool value)public {
        myMappping[index]=value;
    }

    function setMyAdresses(address wallet, uint amount)public{
        myAdresses[wallet]=amount;
    }
    
}