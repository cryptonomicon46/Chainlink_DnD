const HDWalletProvider = require("truffle-hdwallet-provider");


// const HDWalletProvider = require('@truffle/hdwallet-provider');
require("dotenv").config()
// const privateKeys = process.env.PRIVATE_KEYS.split(",")
const privateKey = process.env.PRIVATE_KEY

const projectId = process.env.INFURA_API_KEY
const alchemyAPI = process.env.ALCHEMY_API
const AlchemyHTTP = "https://eth-rinkeby.alchemyapi.io/v2/" + alchemyAPI

// const MNEMONIC = process.env.MNEMONIC;
// const NODE_API_KEY = process.env.INFURA_KEY || process.env.ALCHEMY_KEY;
// const isInfura = !!process.env.INFURA_KEY;

// const needsNodeAPI =
//   process.env.npm_config_argv &&
//   (process.env.npm_config_argv.includes("rinkeby") ||
//     process.env.npm_config_argv.includes("live"));

// if ((!MNEMONIC || !NODE_API_KEY) && needsNodeAPI) {
//   console.error("Please set a mnemonic and ALCHEMY_KEY or INFURA_KEY.");
//   process.exit(0);
// }

// const rinkebyNodeUrl = isInfura
//   ? "https://rinkeby.infura.io/v3/" + NODE_API_KEY
//   : "https://eth-rinkeby.alchemyapi.io/v2/" + NODE_API_KEY;

// const mainnetNodeUrl = isInfura
//   ? "https://mainnet.infura.io/v3/" + NODE_API_KEY
//   : "https://eth-mainnet.alchemyapi.io/v2/" + NODE_API_KEY;

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      gas: 5000000,
    //   gasPrice: 5000000000, // 5 Gwei
      network_id: 5777 // Match any network id
    },
    // rinkeby: {
    //   provider: function () {
    //     return new HDWalletProvider(MNEMONIC, rinkebyNodeUrl);
    //   },
    //   gas: 5000000,
    //   network_id: 4,
    // },
    ropsten: {
	    provider: new HDWalletProvider(privateKey, "https://ropsten.infura.io/v3/" + process.env.INFURA_API_KEY),
	    network_id: 3,
	    gas: 5000000,
		gasPrice: 5000000000, // 5 Gwei
		skipDryRun: true
	  },
	  kovan: {
	    provider: new HDWalletProvider(privateKey, "https://kovan.infura.io/v3/" + process.env.INFURA_API_KEY),
	    network_id: 42,
	    gas: 5000000,
		gasPrice: 5000000000, // 5 Gwei
		skipDryRun: true
	  },
   
      rinkeby: {
        provider: new HDWalletProvider(privateKey, "https://rinkeby.infura.io/v3/" + projectId),
        // provider: new HDWalletProvider(privateKey, AlchemyHTTP,0,3),
        // provider: new HDWalletProvider(privateKeys, "https://rinkeby.infura.io/v3/" + projectId,0,3),
	    network_id: 4,
	    gas: 5000000,
		gasPrice: 2000000000, // 5 Gwei
        networkCheckTimeout: 999999, 
		skipDryRun: true
	  },

    live: {
      network_id: 1,
      provider: function () {
        // return new HDWalletProvider(MNEMONIC, mainnetNodeUrl);
        return new HDWalletProvider(privateKey, "https://rinkeby.infura.io/v3/" + projectId,0,3)
      },
      gas: 5000000,
      gasPrice: 5000000000,
    },
  },
  mocha: {
    reporter: "eth-gas-reporter",
    reporterOptions: {
      currency: "USD",
      gasPrice: 2,
    },
  },
  compilers: {
    solc: {
      version: "^0.8.0",
      settings: {
        optimizer: {
          enabled: true,
          runs: 20   // Optimize for how many times you intend to run the code
        },
      },
    },
  },
  plugins: [
    'truffle-plugin-verify'
  ],
  api_keys: {
    etherscan: process.env.ETHERSCAN_API_KEY
  }
};
