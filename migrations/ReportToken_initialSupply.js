var ReportToken = artifacts.require("ReportToken");

module.exports = function(deployer) {
    // Use deployer to state migration tasks.
    const initialSupply = "200000000000000";
    deployer.deploy(ReportToken,initialSupply);
};