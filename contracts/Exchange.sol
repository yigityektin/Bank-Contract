// SPDX-License-Identifier: MIT
import "./Counter.sol";
import "./Loan.sol";
import "./BalanceTracker.sol";
pragma solidity ^0.8.0;

contract Exchange {
    uint constant public EURO_AGAINST_TURK = 23;
    uint constant public DOLLAR_AGAINST_TURK = 21;
    uint constant public STERLIN_AGAINST_TURK = 26;

    BalanceTracker balanceTracker = new BalanceTracker();
    address owner;
    mapping(address => uint) public balances;
    uint public BANK_OWNED_MONEY = 1000;
    uint temp;

    constructor() {
        owner = msg.sender;
    } 

    function enoughForEuro() public payable {
        temp = balances[owner] * EURO_AGAINST_TURK;
        require(temp >= BANK_OWNED_MONEY, "Bank can't afford that much exchange");
        if(temp <= BANK_OWNED_MONEY) {
            BANK_OWNED_MONEY -= temp;
            balanceTracker.setBalance(owner, "EUR", temp);
        }
    }

    function enoughForDollar() public payable {
        temp = balances[owner] * DOLLAR_AGAINST_TURK;
        require(temp >= BANK_OWNED_MONEY, "Bank can't afford that much exchange");
        if(temp <= BANK_OWNED_MONEY) {
            BANK_OWNED_MONEY -= temp;
            balanceTracker.setBalance(owner, "USD", temp);
        }
    }

    function enoughForSterlin() public payable {
        temp = balances[owner] * STERLIN_AGAINST_TURK;
        require(temp >= BANK_OWNED_MONEY, "Bank can't afford that much exchange");
        if(temp <= BANK_OWNED_MONEY) {
            BANK_OWNED_MONEY -= temp;
            balanceTracker.setBalance(owner, "STR", temp);
        }
    }


}