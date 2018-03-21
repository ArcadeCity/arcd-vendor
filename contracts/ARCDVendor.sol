pragma solidity ^0.4.18;

import "./zeppelin/token/StandardToken.sol";
import "./zeppelin/ownership/Ownable.sol";
import "./zeppelin/math/SafeMath.sol";

contract ARCDVendor is Ownable {

  uint256 public buyPrice;
  StandardToken public myToken;

  address public constant ARCD_TOKEN_ADDRESS = 0x7Ba509375e2Fae3a0860a2A0b82bD975CB30E6b0; // Ropsten

  function ARCDVendor () public {
    myToken = StandardToken(ARCD_TOKEN_ADDRESS);
    buyPrice = 12500000000000;  // 0.0000125 per 1 ETH?
  }

  function setPrices(uint256 newBuyPrice) public onlyOwner {
    buyPrice = newBuyPrice;
  }

  function buy() public payable returns (uint amount){
    amount = msg.value / buyPrice;                    // Calculates the amount of tokens attempting to be purchased
    require(myToken.balanceOf(this) >= amount);       // Checks if this contract has enough token to sell
    myToken.transfer(msg.sender, amount);             // Sends the amount of tokens to the buyer
    return amount;                                    // ends function and returns
  }

}
