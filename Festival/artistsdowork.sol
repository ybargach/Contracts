// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract ArtistsDoWork {
    mapping (address => uint) _ticket;
    address _owner;
    address payable Artists;
    bool once;
    event ticketBought(address indexed buyer, uint ticketcount);
    event getPaid(address artist, uint amount);
    event artistAdded(address);

    constructor() {
        _owner = msg.sender;
        Artists = payable(address(0));
        once = false;
    }

    modifier onlyowner() {
        require(_owner == msg.sender, "You are not the owner");
        _;
    }

    modifier onlyatrist() {
        require(Artists == msg.sender, "You are not the artist");
        _;
    }

    function buyTicket() public payable {
        require(msg.value >= 0.1 ether, "You need at least 0.1 ETH to buy a ticket");
        _ticket[msg.sender] += 1;
        emit ticketBought(msg.sender, _ticket[msg.sender]);
    }

    function addRemuneratedArtist(address address_artist) public onlyowner() {
        require(Artists == address(0), "Artist already added");
        Artists = payable(address_artist);
        emit artistAdded(address_artist);
    }

    function getPayed() public payable onlyatrist() {
        require(once == false, "1 ETH has already been sent");
        require(address(this).balance >= 1 ether, "Insufficient contract balance (1 ETH required)");
        Artists.transfer(1 ether);
        once = true;
        emit getPaid(Artists, 1 ether);
    }

}