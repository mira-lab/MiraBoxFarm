var MiraFactory = artifacts.require("./MiraFactory.sol");
var BuilderTwoFactor = artifacts.require("./BuilderTwoFactor.sol");
var License = artifacts.require('./License.sol');
var Buffer = artifacts.require('./Buffer.sol');

module.exports = function (deployer) {
    //Deploy MiraFactory
    deployer.deploy(MiraFactory)
        .then(() => {
            //Deploy builderPin, builderST contracts
            return deployer.deploy(BuilderTwoFactor);
        })
        .then(() => {
            return deployer.deploy(License);
        })
        .then(() => {
            return License.deployed()
                .then((licenseInstance) => {
                    return licenseInstance.setMiraFactory(MiraFactory.address);
                });
        })
        .then(() => {
            return deployer.deploy(Buffer);
        })
        .then(() => {
            return Buffer.deployed()
                .then((bufferInstance) => {
                    return bufferInstance.setMiraFactory(MiraFactory.address);
                })
        })
        .then(()=>{
            return MiraFactory.deployed()
                .then((miraFactoryInstance)=>{
                    return miraFactoryInstance.setBuffer(Buffer.address);
                })
        })
        .then(()=>{
            return MiraFactory.deployed()
                .then((miraFactoryInstance)=>{
                    return miraFactoryInstance.setLicenseContract(License.address);
                })
        })
        .then(()=>{
            return MiraFactory.deployed()
                .then((miraFactoryInstance)=>{
                    return miraFactoryInstance.addTemplate(BuilderTwoFactor.address);
                })
        })
        .catch((err) => {
            console.log("Error" + err);
        });
};
