// SPDX-License-Identifier:MIT

pragma solidity ^0.8.8;

contract SimpleStorage {
    uint256 public favoriteNumber;

    mapping (string => uint256) public nameTOFavoriteNumber;

    struct People{
        uint256 favoriteNumber;
        string name;
    }

    People[] public people;

    function store(uint256 _favoriteNumber) public virtual{
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

    function addPeople(string memory _name, uint256 _favoriteNumber) public{
        people.push(People(_favoriteNumber, _name));
        nameTOFavoriteNumber[_name] = _favoriteNumber;
    }
}