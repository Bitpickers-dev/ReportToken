var ReportToken = artifacts.require("ReportToken");

module.exports = function (deployer) {
  // Use deployer to state migration tasks.
  const initialSupply = "0";
  deployer.deploy(ReportToken, initialSupply,{
    gas:3000000
  });
};
