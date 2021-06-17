const OurWallet = artifacts.require("OurWallet");

module.exports = function (deployer) {
  deployer.deploy(OurWallet);
};