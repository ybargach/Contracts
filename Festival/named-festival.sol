// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract NamedFestival {
    string _festivalName;

    function setName(string memory input) public {
        _festivalName = input;
    }
    
    function getName() public view returns (string memory) {
        return _festivalName;
    }
}
