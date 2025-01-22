// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    // Mapping to store balances of addresses
    mapping(address => uint256) public balances;
    
    // Mapping to store allowances for spending tokens on behalf of another address
    mapping(address => mapping(address => uint256)) public allowance;
    
    // Total supply of the token
    uint256 public totalSupply;
    
    // Name and symbol of the token
    string public name = "MyToken";
    string public symbol = "MTK";
    uint8 public decimals = 18;

    // Event that is emitted when a transfer occurs
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    // Event that is emitted when an approval is granted
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
    // Constructor to set the initial supply and assign it to the deployer
    constructor(uint256 _initialSupply) {
        balances[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
    }

    // Function to transfer tokens
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] >= _value, "Insufficient balance");
        
        // Transfer the tokens
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        
        // Emit the transfer event
        emit Transfer(msg.sender, _to, _value);
        
        return true;
    }

    // Function to approve another address to spend tokens on your behalf
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        
        // Emit the approval event
        emit Approval(msg.sender, _spender, _value);
        
        return true;
    }

    // Function to transfer tokens on behalf of another address (if approved)
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(balances[_from] >= _value, "Insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "Allowance exceeded");
        
        // Transfer the tokens
        balances[_from] -= _value;
        balances[_to] += _value;
        
        // Deduct the allowance
        allowance[_from][msg.sender] -= _value;
        
        // Emit the transfer event
        emit Transfer(_from, _to, _value);
        
        return true;
    }

    // Function to check the balance of a given address
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }
}
