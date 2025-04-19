// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract OrganizedFestival {
    uint _StartTime;
    string _Place;
    address owner;

    constructor (uint time, string memory place) {
        _StartTime = time;
        _Place = place;
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    function getStartTime() public view returns(uint) {
        return (_StartTime);
    }

    function getPlace() public view returns(string memory) {
        return (_Place);
    }

    function updateStartTime(uint NewTime) public onlyOwner {
        _StartTime = NewTime;
    }

    function updatePlace(string memory NewPlace) public onlyOwner {
        _Place = NewPlace;
    }
}