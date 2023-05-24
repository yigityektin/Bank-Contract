// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    uint public value;

    function increment() public {
        value++;
    }

    function decrement() public {
        value--;
    }

    function reset() public {
        value = 0;
    }

    function current() public view returns(uint) {
        return value;
    }

    // function multiply(uint a, uint b) public pure returns(uint) {
    //     uint result = a * b;
    //     return result;
    // }
}