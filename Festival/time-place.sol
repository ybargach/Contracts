// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract TimeAndPlace {

    uint _TimeStart;
    string _PlaceName;
    
    constructor(uint time, string memory place) {
        _TimeStart = time;
        _PlaceName = place;
    }

    function getPlace() public view returns(string memory) {
        return (_PlaceName);
    }

    function getStartTIme() public view returns(uint) {
        return (_TimeStart);
    }
}