pragma solidity ^0.4.18;

import "./zeppelin/token/StandardToken.sol";
import "./zeppelin/ownership/Ownable.sol";
import "./zeppelin/math/SafeMath.sol";

contract ARCDVendor is Ownable {

  using SafeMath for uint256;

  uint256 public constant decimals = 18;
  uint256 public tokenExchangeRate;
  uint256 public minBuyTokens;

  address public constant ARCD_TOKEN_ADDRESS = 0x7Ba509375e2Fae3a0860a2A0b82bD975CB30E6b0; // Ropsten
  address public constant ETH_DEPOSIT_ADDRESS = 0xfB5234e724b2d44Ab118C3d3d9c000fD4E475509; // Ropsten

  // address public constant ARCD_TOKEN_ADDRESS = 0xb581E3a7dB80fBAA821AB39342E9Cbfd2ce33c23; // Mainnet
  // address public constant ETH_DEPOSIT_ADDRESS = 0x3b2470E99b402A333a82eE17C3244Ff04C79Ec6F; // Mainnet

  StandardToken public myToken;

  function ARCDVendor () public {
    myToken = StandardToken(ARCD_TOKEN_ADDRESS);
    tokenExchangeRate = 80000;
    minBuyTokens = 800 * 10**decimals;
  }

  function setExchangeRate(uint256 newTokenExchangeRate) public onlyOwner {
    tokenExchangeRate = newTokenExchangeRate;
  }

  function setMinBuy(uint256 newMinBuy) public onlyOwner {
    minBuyTokens = newMinBuy * 10**decimals;
  }

  function () public payable {
    require (msg.value != 0);
    uint256 tokensTryingToBuy = msg.value.mul(tokenExchangeRate);   // How much you looking for?
    require (tokensTryingToBuy >= minBuyTokens);              // Return ETH if tokens is less than the min amount
    require (myToken.balanceOf(this) >= tokensTryingToBuy);   // Make sure this contract has enough ARCD
    myToken.transfer(msg.sender, tokensTryingToBuy);          // Sends the amount of tokens to the buyer
    ETH_DEPOSIT_ADDRESS.transfer(msg.value);                  // Forward ETH to the final deposit address
  }

}
