// SPDX-License-Identifier: MIT
import "./Counter.sol";
import "./BalanceTracker.sol";
pragma solidity ^0.8.0;

contract Bank {
    mapping(address => mapping(string => uint)) public balances;
    address owner;
    Counter counter;
    uint usdBalance;
    uint euroBalance;
    uint sterlinBalance;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function deposit(string memory currency) public payable onlyOwner {
        require(msg.value > 0, "Value must be higher than zero");
        balances[owner][currency] += msg.value;
    }

    function checkBalance(address user, string memory currency) internal view returns (uint) {
        return balances[user][currency];
    }

    function checkAllBalance(string memory currency) public view returns(address[] memory, uint[] memory) {
        address[] memory addresses;
        uint[] memory balancesByCurrency;
        uint count = 0;
        for(uint i=0; i<addresses.length; i++) {
            if(balances[addresses[i]][currency] > 0) {
                count++;
            }
        }
        addresses = new address[](count);
        balancesByCurrency = new uint[](count);
        uint index = 0;
        for(uint i=0; i<addresses.length; i++) {
            if(balances[addresses[i]][currency] > 0) {
                addresses[index] = addresses[i];
                balancesByCurrency[index] = balances[addresses[i]][currency];
                index++;
            }
        }
        return (addresses, balancesByCurrency);
    }

    function checkDollarBalance() public view returns(address[] memory, uint[] memory) {
        return checkAllBalance("USD");
    }

    function checkEuroBalance() public view returns(address[] memory, uint[] memory) {
        return checkAllBalance("EUR");
    }

    function checkSterlinBalance() public view returns(address[] memory, uint[] memory) {
        return checkAllBalance("STR");
    }

    function viewSender() public view returns(address) {
        return owner;
    }

    function withdraw(uint amount, string memory currency) public onlyOwner {
        require(balances[owner][currency] >= amount, "Balance should be higher than the amount");
        balances[owner][currency] -= amount;
        payable(owner).transfer(amount);
    }

    function transfer(uint amount, address to, string memory currency) public onlyOwner {
        require(balances[owner][currency] >= amount, "Balance should be higher than or equal to amount");
        balances[owner][currency] -= amount;
        balances[to][currency] += amount;
    }

    function viewValue() public view returns(uint) {
        return counter.current();
    }

    function incrementValue() public onlyOwner {
        counter.increment();
    }

    function decrementValue() public onlyOwner {
        counter.decrement();
    }

    function resetTheAssets() public onlyOwner {
        counter.reset();
    }
}