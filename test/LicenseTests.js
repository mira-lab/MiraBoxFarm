// let License = artifacts.require('./License.sol');
// let Buffer = artifacts.require('./Buffer.sol');
// let MiraFactory = artifacts.require('./MiraFactory.sol');
// let PSSP = artifacts.require("./PinSecretStorePermissions.sol");
// let Onrequest = artifacts.require("./Onrequest.sol");
// contract('License ERC20 token tests', async (accounts)=> {
//
//     it("Should mint 5000 tokens to 0 account.", async () => {
//         let LicenseInstance = await License.deployed();
//         await LicenseInstance.mint(accounts[0], 5000);
//         let balanceOfAccount = await LicenseInstance.balanceOf(accounts[0]);
//         assert(balanceOfAccount, 5000);
//     });
//     it("Should add public key to buffer.", async () => {
//         let BufferInstance = await Buffer.deployed();
//         let addKeyResult = await BufferInstance.addKey('1234567890');
//         assert(addKeyResult, true);
//     });
//     it("Should buy mirabox. Mirabox contract should have public key in it.", async () => {
//         let MiraFactoryInstance = await MiraFactory.deployed();
//         let LicenseInstance = await License.deployed();
//         let MiraboxContract = await LicenseInstance.buyMirabox("Onrequest");
//         console.log(MiraboxContract.logs);
//         let MiraboxContractInstance = Onrequest.at(MiraboxContract);
//         let publicKeyFromMirabox = await MiraboxContractInstance.getPublicKey.call();
//         assert(publicKeyFromMirabox, '1234567890');
    });
});
// contract('License ERC20 token tests', async (accounts)=>{
//     const fakeMirabox = web3.fromAscii("12345xx32");
//     let fakePublicKeys = ['1', '2', '3', '123', '12345'].map((value) => {return web3.fromAscii(value)});
//     it("Should mint 5000 tokens to 0 account.", async () => {
//         let LicenseInstance = await License.deployed();
//         await LicenseInstance.mint(accounts[0], 5000);
//         let balanceOfAccount = await LicenseInstance.balanceOf(accounts[0]);
//         assert(balanceOfAccount, 5000);
//     });
//     it("Should add key to buffer", async () => {
//         let BufferInstance = await Buffer.deployed();
//         let addKeyResult = await BufferInstance.addKey(fakePublicKeys[0]);
//         assert(addKeyResult, true);
//     });
//     it("Should buy mirabox. Mirabox contract should have public key in it.", async () => {
//         let PSSPInstance = await PSSP.deployed();
//         let LicenseInstance = await License.deployed();
//         await LicenseInstance.buyMirabox(fakeMirabox, "Onrequest");
//         let MiraboxContract = await PSSPInstance.getMiraBoxContract.call(fakeMirabox);
//         let MiraboxContractInstance = Onrequest.at(MiraboxContract);
//         let publicKeyFromMirabox = MiraboxContractInstance.getPublicKey.call();
//         assert(publicKeyFromMirabox, fakePublicKeys[0]);
//     });
//     it("Should have 4999 tokens.", async () => {
//         let LicenseInstance = await License.deployed();
//         let balanceOfAccount = LicenseInstance.balanceOf(accounts[0]);
//         assert(balanceOfAccount, 4999);
//     });
//
// });