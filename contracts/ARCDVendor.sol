pragma solidity ^0.4.18;

import "./zeppelin/token/StandardToken.sol";
import "./zeppelin/ownership/Ownable.sol";
import "./zeppelin/math/SafeMath.sol";

contract ARCDVendor is Ownable {

  uint256 public buyPrice;

  address public constant ARCD_TOKEN_ADDRESS = 0xb581E3a7dB80fBAA821AB39342E9Cbfd2ce33c23;

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
