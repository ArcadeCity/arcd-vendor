pragma solidity ^0.4.18;

import "./zeppelin/token/StandardToken.sol";
import "./zeppelin/ownership/Ownable.sol";
import "./zeppelin/math/SafeMath.sol";

contract ARCDVendor is Ownable {

  using SafeMath for uint256;

  StandardToken public myToken;

  uint256 public constant decimals = 18;

  address public constant ARCD_TOKEN_ADDRESS = 0x7Ba509375e2Fae3a0860a2A0b82bD975CB30E6b0; // Ropsten
  address public constant ETH_DEPOSIT_ADDRESS = 0xfB5234e724b2d44Ab118C3d3d9c000fD4E475509; // Ropsten

  uint256 public tokenExchangeRate;
  uint256 public minBuyTokens;

  function ARCDVendor () public {
    myToken = StandardToken(ARCD_TOKEN_ADDRESS);
    tokenExchangeRate = 80000;
    minBuyTokens = 8000 * 10**decimals;
  }

  function setExchangeRate(uint256 newTokenExchangeRate) public onlyOwner {
    tokenExchangeRate = newTokenExchangeRate;
  }

  function () public payable {
    require (msg.value != 0);
    uint256 tokensTryingToBuy = msg.value.mul(tokenExchangeRate);
    require (tokensTryingToBuy >= minBuyTokens);                          // return ETH if tokens is less than the min amount
    require (myToken.balanceOf(this) >= tokensTryingToBuy);
    myToken.transfer(msg.sender, tokensTryingToBuy);          // Sends the amount of tokens to the buyer
    ETH_DEPOSIT_ADDRESS.transfer(msg.value);
  }

}
