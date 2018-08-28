var MiraFactory = artifacts.require("./MiraFactory.sol");
var PinSecretStorePermissions = artifacts.require("./PinSecretStorePermissions.sol");
var BuilderOnrequest = artifacts.require("./BuilderOnrequest.sol");
var BuilderST = artifacts.require("./BuilderST.sol");
var License = artifacts.require('./License.sol');
var Buffer = artifacts.require('./Buffer.sol');

module.exports = function (deployer) {
    //Deploy MiraFactory
    deployer.deploy(MiraFactory)
        .then(() => {
            //Deploy builderPin, builderST contracts
            return deployer.deploy(BuilderOnrequest);
        })
        // .then((miraFactoryInstance) => {
        //     //Call MiraFactory's setAClcontract function
        //     let setACLPromise = new Promise((resolve, reject) => {
        //         miraFactoryInstance.setBufferContract(PinSecretStorePermissions.address)
        //             .then(() => {
        //                 resolve();
        //             }, (err) => {
        //                 reject("setACLPromise failed with err:" + err);
        //             });
        //     });
        //     //Call MiraFactory's addTemplate function with BuilderPin contract address
        //     let addTemplatePinPromise = new Promise((resolve, reject) => {
        //         miraFactoryInstance.addTemplate(BuilderOnrequest.address)
        //             .then(() => {
        //                 resolve();
        //             }, (err) => {
        //                 reject("addTemplatePinPromise failed with err:" + err);
        //             });
        //     });
        //     //Call MiraFactory's addTemplate function with BuilderST contract address
        //     let addTemplateSTPromise = new Promise((resolve, reject) => {
        //         miraFactoryInstance.addTemplate(BuilderST.address)
        //             .then(() => {
        //                 resolve();
        //             }, (err) => {
        //                 reject("addTemplateSTPromise failed with err:" + err);
        //             });
        //     });
        //     return Promise.all([setACLPromise, addTemplatePinPromise, addTemplateSTPromise]);
        // })
        // .then(() => {
        //     console.log("setACLPromise - success!");
        //     console.log("addTemplatePinPromise - success!");
        //     console.log("addTemplateSTPromise - success!");
        // })
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
                    return miraFactoryInstance.addTemplate(BuilderOnrequest.address);
                })
        })
        .catch((err) => {
            console.log("Error" + err);
        });
};
