const DungeonsAndDragons = artifacts.require("DungeonsAndDragon");
// const { LinkToken } = require('@chainlink/contracts/truffle/v0.4/LinkToken')
const RINKEBY_VRF_COORDINATOR = '0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B'
const RINKEBY_LINK_TOKEN = '0x01BE23585060835E02B77ef475b0Cc51aA1e0709'
const RINKEBY_KEYHASH = '0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311'


module.exports = async (deployer) => {
    // Local (development) networks need their own deployment of the LINK
    // token and the Oracle contract
    // if (!network.startsWith('kovan')) {
    //     console.log("only for Kovan right now!")
    // } else {
        // For now, this is hard coded to Kovan
        // const KOVAN_KEYHASH = '0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4'
        // const KOVAN_LINK_TOKEN = '0xa36085F69e2889c224210F603D836748e7dC0088'
        // const KOVAN_VRF_COORDINATOR = '0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B'
        
        // await deployer.deploy(DungeonsAndDragons,KOVAN_VRF_COORDINATOR, KOVAN_LINK_TOKEN, KOVAN_KEYHASH)

        // LinkToken.setProvider(deployer.provider)
        // DungeonsAndDragonsCharacter.setProvider(deployer.provider)
        await deployer.deploy(DungeonsAndDragons,RINKEBY_VRF_COORDINATOR, RINKEBY_LINK_TOKEN, RINKEBY_KEYHASH)
        let dnd = await DungeonsAndDragons.deployed()

    // }

}