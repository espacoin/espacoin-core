var ESPATokenSale = artifacts.require("./ESPATokenSale.sol");


// Copy & Paste this
Date.prototype.getUnixTime = function() { return this.getTime()/1000|0 };
if(!Date.now) Date.now = function() { return new Date(); }
Date.time = function() { return Date.now().getUnixTime(); }


var tokenSaleContract;

module.exports = function(deployer) {

   //  const publicSaleStartTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + 1 // one second in the future
   //  const publicSaleEndTime = publicSaleStartTime + (86400 * 20) // 20 days
   //  console.log( "#################################################################################");
   //  console.log( "publicSaleStartTime : "+publicSaleStartTime);
   //  console.log( "publicSaleStartTime : "+new Date(publicSaleStartTime*1000));
   //  console.log( "publicSaleEndTime : "+publicSaleEndTime);
   //  console.log( "publicSaleEndTime : "+new Date(publicSaleEndTime*1000));
   //  console.log( "#################################################################################");
   //  // return ESPATokenSale.new(publicSaleStartTime, publicSaleEndTime).then(function(result){
   //  //     tokenSaleContract = result;
   //  //     console.log("ESPATokenSale: "+tokenSaleContract.address);
   //  // });
   //  deployer.deploy(ESPATokenSale, publicSaleStartTime, publicSaleEndTime);
};
