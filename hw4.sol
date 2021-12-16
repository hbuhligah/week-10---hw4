pragma solidity ^0.8.0;

contract EmptyContract{

}

contract PrintContract{

    string public message;

    constructor(string memory _message)  {
        message = _message;
    }
}

contract Bank{
 
    mapping(address=>uint256) balances;
    uint256 bankBalance = 0;

    receive() external payable{
        balances[msg.sender] += msg.value;
        bankBalance += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount,  "Balance not enough");
        balances[msg.sender] -= amount;
        bankBalance -= amount;
        payable(msg.sender).transfer(amount);
    }

    function transfer(address recipient, uint256 amount) external {
        require(balances[msg.sender] >= amount, "Balance not enough");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
    }

    function getUserBalance() external view returns(uint256){
        return balances[msg.sender];
    }

    function getBankBalance() external view returns(uint256){
        return bankBalance;
    }

}