const DriversContract = artifacts.require("DriversContract");

module.exports = function (deployer) {
  deployer.deploy(DriversContract);
};
