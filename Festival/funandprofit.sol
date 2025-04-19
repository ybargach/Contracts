// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract FunAndProfit {
    mapping (address => uint) _ticket;
    address payable _owner;
    address payable _redeem_address;
    event buyticket(address indexed, uint amount);
    event refund(address indexed, uint amount);
    event benefit(address indexed, uint amount);

    constructor() {
        _owner = payable(msg.sender);
    }

    modifier onlyowner() {
        require( msg.sender == _owner, "you are not the owner");
        _;
    }

    function buyTicket() public payable {
        require(msg.value >= 0.1 ether, "You need at least 0.1 Eth to buy a ticket");
        _ticket[msg.sender] += 1;
        emit buyticket(msg.sender, msg.value);
    }

    function ticketsOf(address _address) view public returns(uint) {
        return (_ticket[_address]);
    }

    function redeemTicket() public payable {
        require(_ticket[msg.sender] > 0, "You do not have a ticket");
        _redeem_address = payable(msg.sender);
        _redeem_address.transfer(0.1 ether);
        _ticket[msg.sender] -= 1;
        emit refund(msg.sender, 0.1 ether);
    }

    function getBenefits() public payable onlyowner() {
        require(address(this).balance > 0, "No balance available for benefits");
        _owner.transfer(address(this).balance);
        emit benefit(msg.sender, address(this).balance);
    }
    
}