//SPDX-License-Identifier:MIT

pragma solidity ^0.8.8;
// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

import "./PriceConverter.sol";

contract FundMe{

    using PriceConverter for uint256;

    uint256 public minimumUsd = 50;

    address[] public funders;

    mapping (address => uint256) public addressToAmountList;

    address public owner;

    error NotOwner();

    constructor(){
        owner = msg.sender;
    }

    function fund() public payable{

        require(msg.value.getConversionRate() > minimumUsd, "Didn't send enoungh!");
        funders.push(msg.sender);
        addressToAmountList[msg.sender] = msg.value;
    }

    function withdraw() public {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountList[funder] = 0;
        }

        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{value:address(this).balance}("");
        require(callSuccess, "call failed!");
    }

    modifier onlyOwner{
        if (msg.sender != owner) {revert NotOwner();}
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

}