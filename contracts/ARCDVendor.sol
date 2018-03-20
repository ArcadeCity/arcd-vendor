pragma solidity ^0.4.18;

import "./zeppelin/token/StandardToken.sol";
import "./zeppelin/ownership/Ownable.sol";
import "./zeppelin/math/SafeMath.sol";

contract ARCDVendor is Ownable {

  uint256 public buyPrice;
  StandardToken public myToken;

  /* address public constant ARCD_TOKEN_ADDRESS = 0xb581E3a7dB80fBAA821AB39342E9Cbfd2ce33c23; */

  function ARCDCrowdsale () public {
    myToken = new StandardToken();
  }

  function setPrices(uint256 newBuyPrice) onlyOwner {
    buyPrice = newBuyPrice;
  }

  function setToken(address tokenAddress) onlyOwner {
    myToken = StandardToken(tokenAddress);
  }

  function buy() payable returns (uint amount){
    amount = msg.value / buyPrice;                    // Calculates the amount of tokens attempting to be purchased
    require(myToken.balanceOf(this) >= amount);       // Checks if this contract has enough token to sell
    myToken.transfer(msg.sender, amount);             // Sends the amount of tokens to the buyer
    /* Transfer(this, msg.sender, amount);               // execute an event reflecting the change */
    return amount;                                    // ends function and returns
  }

}
