pragma solidity ^0.4.17;

contract ARCDVendor {

  uint256 public buyPrice;

  function setPrices(uint256 newBuyPrice) onlyOwner {
    buyPrice = newBuyPrice;
  }

  function buy() payable returns (uint amount){
    amount = msg.value / buyPrice;                    // calculates the amount
    require(balanceOf[this] >= amount);               // checks if it has enough to sell
    balanceOf[msg.sender] += amount;                  // adds the amount to buyer's balance
    balanceOf[this] -= amount;                        // subtracts amount from seller's balance
    Transfer(this, msg.sender, amount);               // execute an event reflecting the change
    return amount;                                    // ends function and returns
  }

}
