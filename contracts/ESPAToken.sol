pragma solidity ^0.4.18;

import './base/token/StandardToken.sol';
import './base/ownership/Ownable.sol';

/**
 * @title The ESPAcoin contract
 * @dev The ESPA Token contract
 * @dev inherits from StandardToken and Ownable by Zeppelin
 * @author The Enterpreneur
 */

contract ESPAToken is StandardToken, Ownable {
    string  public  constant name = "ESPA Token";
    string  public  constant symbol = "ESPA";
    uint8    public  constant decimals = 18;

    modifier validDestination(address to) 
    {
        require(to != address(this));
        _;
    }

    function ESPAToken(uint tokenTotalAmount) {
        // Mint all tokens. Then disable minting forever.
        totalSupply = tokenTotalAmount;
        balances[msg.sender] = totalSupply;
        Transfer(address(0x0), msg.sender, totalSupply);
    }

    /**
     * @dev override transfer token for a specified address to add onlyWhenTransferEnabled and validDestination
     * @param _to The address to transfer to.
     * @param _value The amount to be transferred.
     */
    function transfer(address _to, uint _value)
        public
        validDestination(_to)
        returns (bool) 
    {
        return super.transfer(_to, _value);
    }

    /**
     * @dev override transferFrom token for a specified address to add onlyWhenTransferEnabled and validDestination
     * @param _from The address to transfer from.
     * @param _to The address to transfer to.
     * @param _value The amount to be transferred.
     */
    function transferFrom(address _from, address _to, uint _value)
        public
        validDestination(_to)
        returns (bool) 
    {
        return super.transferFrom(_from, _to, _value);
    }

    event Burn(address indexed _burner, uint _value);

    /**
     * @dev burn tokens
     * @param _value The amount to be burned.
     * @return always true (necessary in case of override)
     */
    function burn(uint _value) 
        public
        returns (bool)
    {
        balances[msg.sender] = balances[msg.sender].sub(_value);
        totalSupply = totalSupply.sub(_value);
        Burn(msg.sender, _value);
        Transfer(msg.sender, address(0x0), _value);
        return true;
    }

    /**
     * @dev burn tokens in the behalf of someone
     * @param _from The address of the owner of the token.
     * @param _value The amount to be burned.
     * @return always true (necessary in case of override)
     */
    function burnFrom(address _from, uint256 _value) 
        public
        returns(bool) 
    {
        assert(transferFrom(_from, msg.sender, _value));
        return burn(_value);
    }
}
