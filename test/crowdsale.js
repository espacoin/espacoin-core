var ESPATokenSale = artifacts.require("./ESPATokenSale.sol");
var ESPAToken = artifacts.require("./ESPAToken.sol");


contract('Buy token sale', function(accounts) {
	// account setting ----------------------------------------------------------------------
	var foundationWallet = accounts[0];
	var investor = accounts[1];

    // variable to host contracts ------------------------------------------------------------
	var espaTokenSale;
	var espaToken;

    const rateETHESPA = 1000

	beforeEach(async () => {
        const publicSaleStartTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + 1
        const publicSaleEndTime = publicSaleStartTime + (86400 * 20) // 20 days

		espaTokenSale = await ESPATokenSale.new(publicSaleStartTime, publicSaleEndTime);
		espaToken = await ESPAToken.at(await espaTokenSale.token.call());
	});

	it("buys tokens ", async function() {
		var walletBalanceEthBefore = await web3.eth.getBalance(foundationWallet);
		var weiSpend = web3.toWei(100, "ether");

		var r = await espaTokenSale.sendTransaction({from: investor,value:weiSpend});

		assert.equal(r.logs[0].event, 'TokenPurchase', "event is wrong");
		assert.equal(r.logs[0].args.purchaser, investor, "purchaser is wrong");
		assert(r.logs[0].args.value.equals(weiSpend), "value is wrong");
		assert(r.logs[0].args.amount.equals(weiSpend*rateETHESPA), "amount is wrong");

        investorBalance = await espaToken.balanceOf(investor)
        foundationBalance = await web3.eth.getBalance(foundationWallet)
        tokensLeft = await espaToken.balanceOf(espaTokenSale.address);

        assert.equal(investorBalance.toNumber(), weiSpend * rateETHESPA); 
	});

});


