pragma solidity ^0.4.18;

import "./StandardCrowdsale.sol";
import "./base/token/StandardToken.sol";
import "./ESPAToken.sol";

/**
 * @title ESPATokenSale
 * @dev 
 * The code is based on the contracts of Open Zeppelin and we add our contracts : ESPATokenSale and the ESPA Token
 * @author ESPAcoin.com
 */

contract ESPATokenSale is Ownable, StandardCrowdsale {
    // hard cap of the token sale in ether

    // Total of ESPA Token supply
    uint public constant TOTAL_ESPA_TOKEN_SUPPLY = 21000000e18;
    // Token initialy distributed for the early foundation (30%)
    uint public constant ESPA_FOUNDATION_AMOUNT = 7000000e18;

    // wallet use also to gather the ether of the token sale
    address private constant ESPA_FOUNDATION_WALLET = 0x64d8451729d79fd43cf1bcb5772d43349987e070; 

    // Token sale rate from ETH to ESPA
    uint private constant RATE_ETH_ESPA = 1000;


    function ESPATokenSale(uint256 _startTime, uint256 _endTime) public
      StandardCrowdsale(_startTime, _endTime, RATE_ETH_ESPA, ESPA_FOUNDATION_WALLET)
    {
        token = createTokenContract();
        token.transfer(ESPA_FOUNDATION_WALLET, ESPA_FOUNDATION_AMOUNT);
    }

    /**
     * @dev Create the ESPA token (override createTokenContract of StandardCrowdsale)
     * @return the StandardToken created
     */
    function createTokenContract () 
      internal 
      returns(StandardToken) 
    {
        return new ESPAToken(TOTAL_ESPA_TOKEN_SUPPLY);
    }

}
  
