# Chainlink_Dnd same as the other DND project

both git clone https://github.com/PatrickAlphaC/dungeons-and-dragons-nft
and truffle unbox truffle unbox smartcontractkit/box
gave compile errors. 

So I started from scratch
truffle init

npm init 

I then installed the dependencies manually 
npm install dovenv --save
npm install @openzeppelin/contracts@next --save
npm install @truffle/hdwallet-provider --save
npm install @chainlink/contracts --save
npm install -D truffle-plugin-verify --save

    "@chainlink/contracts": "^0.4.0",
    "@openzeppelin/contracts": "^4.5.0-rc.0",
    "@truffle/hdwallet-provider": "^2.0.3",
    "dotenv": "^16.0.0"
Created my .env file, and truffle config for developement, kovan, rinkeby, ropsten and kovan.
You'll require to program your Infuria ID and private keys in the .env file.




truffle console --network kovan migrate --all
compile -all
migrate --reset 


get Etherscan API key
truffle run verify SimpleNFT --network kovan --license MIT
https://kovan.etherscan.io/address/0x93BBE9D48EfD8d38E857BCD98c09Fb185b88244E#code
View the contract here on ether scan 
https://kovan.etherscan.io/address/0x08961f9B1e60b655Dec1c6f3d50B717Edd546b13#code


    * Network: Rinkeby
     VrfcoordinatorV1: 0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B
     VrfcoordinatorV2: 0x6168499c0cFfCaCD319c818142124B7A15E857ab
     LinkToken (V1/V2): 0x01BE23585060835E02B77ef475b0Cc51aA1e0709
     KeyHash: 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311
     */


     /* Network: KOVAN
     VrfCoordinatorV1: 0xdD3782915140c8f3b190B5D67eAc6dc5760C46E9
     LinkToken: 0xa36085F69e2889c224210F603D836748e7dC0088
     KeyHash: 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4

     */
Verification of the contract on Etherscan:

     truffle run verify DungeonsAndDragons --license MIT
     On Kovan:
Pass1 - Verified: https://kovan.etherscan.io/address/0xfd1F5a5890e66D007f884011e7EF8C8f82089119#code
Pass2 Verified https://kovan.etherscan.io/address/0xFd3210cfba6e8f8281A4fE6DdB1E809B488E7C5D#code
Pass3 Verified https://kovan.etherscan.io/address/0x8Ba3dD99C6a082c4f480896CbC49EaE5E016649b#code

On Rinkeby 'DungeonsAndDragons" *
     truffle run verify DungeonsAndDragons --license MIT --network rinkeby
     https://rinkeby.etherscan.io/address/0xAc065FFbc99FA560db9Ee873628Fb64fc15BcB1C#code


truffle exec scripts/set-token-uri.js --network rinkeby


    truffle exec scripts/set-token-uri.js --network kovan

    truffle exec scripts/generate-characters.js --network kovan
    exec scripts/get-characters.js
    exec scripts/set-token-uri.js


Fund the contract:
exec scripts/fund-contract.js



On Rinkeby 'DungeonsAndDragon" *
     truffle run verify DungeonsAndDragon --license MIT --network rinkeby
     Contract Address: 0x70f3E5B8a669531cAccE7be616D5449A0f8e178B
     
     https://rinkeby.etherscan.io/address/0x70f3E5B8a669531cAccE7be616D5449A0f8e178B#code
     Fund this contract with 5 LINK
