// const MiraFactory = artifacts.require("./MiraFactory.sol");
// const BuilderST = artifacts.require("./BuilderST.sol");
// const BuilderOnrequest = artifacts.require("./BuilderOnrequest.sol");
//
// contract('MiraFactory templates test', async (accounts)=>{
//
//   it("Should add SimpleTime template to templates mapping", async () => {
//     let MiraFactoryInstance = await MiraFactory.deployed();
//     let BuilderSTInstance = await BuilderST.deployed();
//     let BuilderSTName = await BuilderSTInstance.getName.call();
//     let BuilderSTAddress = await MiraFactoryInstance.templates.call(web3.fromAscii(BuilderSTName));
//     assert(BuilderSTAddress, BuilderST.address);
//   });
//
//   it("Should form correct json string with SimpleTime template metadata", async () => {
//     let MiraFactoryInstance = await MiraFactory.deployed();
//     let BuilderSTInstance = await BuilderST.deployed();
//     let BuilderSTName = await BuilderSTInstance.getName.call();
//     let BuilderSTVersion = await BuilderSTInstance.getVersion.call();
//     let BuilderSTAuthor = await BuilderSTInstance.getAuthor.call();
//     let templatesJsonString = await MiraFactoryInstance.getTemplatesList.call();
//     let shouldBeTemplatesJsonString = `{"templates":
// [{"name": "${BuilderSTName}","version": "${BuilderSTVersion}","author": "${BuilderSTAuthor}","address": "${BuilderST.address}"}]}`;
//     assert(templatesJsonString, shouldBeTemplatesJsonString);
//   });
//
//   it("Should add Pin template to templates mapping", async () => {
//     let MiraFactoryInstance = await MiraFactory.deployed();
//     let BuilderPinInstance = await BuilderOnrequest.deployed();
//     let BuilderPinName = await BuilderPinInstance.getName.call();
//     let BuilderPinAddress = await MiraFactoryInstance.templates.call(web3.fromAscii(BuilderPinName));
//     assert(BuilderPinAddress, BuilderOnrequest.address);
//   });
//
//   it("Should correctly add Pin template metadata to json string", async () => {
//     let MiraFactoryInstance = await MiraFactory.deployed();
//     let BuilderSTInstance = await BuilderST.deployed();
//     let BuilderPinInstance = await BuilderOnrequest.deployed();
//     let BuilderSTName = await BuilderSTInstance.getName.call();
//     let BuilderSTVersion = await BuilderSTInstance.getVersion.call();
//     let BuilderSTAuthor = await BuilderSTInstance.getAuthor.call();
//     let BuilderPinName = await BuilderPinInstance.getName.call();
//     let BuilderPinVersion = await BuilderPinInstance.getVersion.call();
//     let BuilderPinAuthor = await BuilderPinInstance.getAuthor.call();
//     let templatesJsonString = await MiraFactoryInstance.getTemplatesList.call();
//     let shouldBeTemplatesJsonString = `{"templates":
// [{"name": "${BuilderSTName}","version": "${BuilderSTVersion}","author": "${BuilderSTAuthor}","address": "${BuilderST.address}"},
// [{"name": "${BuilderPinName}","version": "${BuilderPinVersion}","author": "${BuilderPinAuthor}","address": "${BuilderOnrequest.address}"}]}`;
//     assert(templatesJsonString, shouldBeTemplatesJsonString);
//   });
//
// });
