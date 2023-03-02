// SPDX-Licence-Identifier : MIT
pragma solidity ^0.8.13;

contract Banking {
    mapping(address => uint256) public balances;
    address payable owner;

    constructor() public {
        owner = payable(msg.sender);
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(msg.sender == owner, "Only owner can withdraw funds");
        require(amount <= balances[msg.sender], "Not enough fund in account");
        require(amount > 0, "Withdrawl amount must be greater than 0");
        payable(msg.sender).transfer(amount);
        balances[msg.sender] -= amount;
    }

    function transfer(address payable recipient, uint256 amount) public {
        require(amount <= balances[msg.sender], "Not enough fund in account");
        require(amount > 0, "Transfer account must be greater than 0");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
    }

    function getBalance(address payable user) public view returns (uint256) {
        return balances[user];
    }

    function grantAccess(address payable user) public {
        require(msg.sender == owner, "You are not authorized for the action");
        owner = user;
    }

    function revokeAccess(address payable user) public {
        require(msg.sender == owner, "You are not authorized for the action");
        require(user != owner, "Cannot revoke access for the current user");
        owner = payable(msg.sender);
    }

    function destroy() public {
        require(msg.sender == owner, "You are not authorized for the action");
        selfdestruct(owner);
    }
}
