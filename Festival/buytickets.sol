// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract BuyTickets {
    mapping(address => uint) _UserBuy;
    event buyticket(address indexed, uint amount);
    
    function buyTicket() public payable {
        require(msg.value >= 0.1 ether, "You need at least 0.1 Eth to buy a ticket");
        _UserBuy[msg.sender] += 1;
        emit buyticket(msg.sender, msg.value);
    }

    function ticketoff(address Id) view public returns(uint) {
        return (_UserBuy[Id]);
    }
}