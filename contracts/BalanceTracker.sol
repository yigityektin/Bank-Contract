// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BalanceTracker {
    mapping(address => mapping(string => uint)) public balances;

    function setBalance(address user, string memory currency, uint balance) public {
        balances[user][currency] = balance;
    }

    function getBalance(address user, string memory currency) public view returns (uint) {
        return balances[user][currency];
    }

    // function checkBalance(address user, string memory currency) public view returns(uint) {
    //     require(bytes(currency).length > 0, "Currency can't be empty");
    //     return balances[user][currency];
    // }

    function checkBalance(address user, string memory currency) internal view returns (uint) {
        return balances[user][currency];
    }
}
