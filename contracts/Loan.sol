// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Loan {
    uint constant public BANK_OWNED_MONEY = 1000;
    mapping(address => uint) public balances;
    uint wantedMoney;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    function TakeLoan() public payable {
        balances[owner] += wantedMoney;
    }

    function AcceptableLoanAmount() public {
        require(wantedMoney >= BANK_OWNED_MONEY, "You can't take that much loan");
        if(wantedMoney <= BANK_OWNED_MONEY) {
            TakeLoan();
        }
    }
}