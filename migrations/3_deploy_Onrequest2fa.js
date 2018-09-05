let BuilderOnerequest2fa = artifacts.require("./BuilderOnrequest2fa.sol");
let MiraFactory = artifacts.require("./MiraFactory.sol");
module.exports = function (deployer) {
    deployer.deploy(BuilderOnerequest2fa)
        .then(() => MiraFactory.deployed())
        .then(miraFactoryInstance =>  miraFactoryInstance.addTemplate(BuilderOnerequest2fa.address))
        .catch(err => console.log(err));
};