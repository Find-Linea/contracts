import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    linea_sepolia: {
      accounts: ["PRIVATE_KEY"],
      url: "https://rpc.sepolia.linea.build",
    },
  },
  defaultNetwork: "linea_sepolia",
};

export default config;
