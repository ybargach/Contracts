// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract TimeIsMoney {
    uint date_festival;
    address payable _owner;
    address payable _artist;
    mapping (address => uint) _ticket;
    bool once;
    event buyticket(address indexed buyer, uint ticketcount);
    event addartist(address indexed artist);
    event payedartist(address indexed artist, uint amount);
    event benefit(address indexed owner, uint amount);

    constructor(uint date) {
        date_festival = date;
        _owner = payable(msg.sender);
        _artist = payable(address(0));
        once = false;
    }

    modifier onlyowner() {
        require(_owner == msg.sender, "You are not the owner");
        _;
    }

    modifier onlyartist() {
        require(_artist == msg.sender, "You are not the artist");
        _;
    }

    function buyTicket() public payable {
        if (block.timestamp <= date_festival - 10 days)
            require(msg.value >= 0.01 ether, "You need at least 0.01 to buy a ticket");
        else
            require(msg.value >= 0.1 ether, "You need at least 0.1 to buy a ticket");
        _ticket[msg.sender] += 1;
        emit buyticket(msg.sender, _ticket[msg.sender]);
    }

    function ticketsOf() view public returns (uint){
        return (_ticket[msg.sender]);
    }

    function addPayedArtist(address add_artist) public onlyowner() {
        require(_artist == address(0), "An artist has already been added");
        _artist = payable(add_artist);
        emit addartist(add_artist);
    }

    function getPayed() public payable onlyartist() {
        require(once == false, "You have already received your payment");
        require(address(this).balance >= 1 ether, "Insufficient contract balance (1 ETH required)");
        require(block.timestamp >= date_festival + 3 days, "You must wait 3 days after the festival");
        _artist.transfer(1 ether);
        once = true;
        emit payedartist(_artist, 1 ether);
    }

    function getBenefits() public payable onlyowner() {
        require(block.timestamp >= date_festival + 10 days, "You must wait 10 days after the festival");
        require(once != false, "You must wait 30 days if the artist hasn't withdrawn their payment");
        require(address(this).balance > 0, "Contract has no funds available");
        _owner.transfer(address(this).balance);
        emit benefit(_owner, address(this).balance);
    }
}