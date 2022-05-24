// SPDX-License-Identifier:GPL-3.0
pragma solidity 0.8.0;
contract Inbox{

    string public message;
    address private ownerAddress;
    constructor(string memory initialMessage){

        ownerAddress= msg.sender;
        message= initialMessage;
    }

    
    function getMessage()public view returns(string memory){
        return message;
    }
    function setMessage(string memory newMessage)public ownerRestricted(msg.sender){
        //require ( bytes(newMessage).length > 10,"el mensaje tiene que tener ma de 10 caracteres");
        //require(msg.sender==ownerAddress,"Solo el owner puede modificar el mensage");

        message=newMessage;
        
    }
    function getOwnerAddress()public view returns(address){
         require(msg.sender==ownerAddress,"Solo el owner puede modificar el mensage");
        return ownerAddress;

    }

    modifier ownerRestricted(address client){
          require(client==ownerAddress,"Solo el owner puede modificar el mensaje");
          _;
    }
}