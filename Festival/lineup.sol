// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract LineUp {
    string[] _NameArtists;

    function addArtist(string memory Name) public {
        _NameArtists.push(Name);
    }

    function lineup(uint number) view public returns(string memory) {
        return(_NameArtists[number]);
    }
}