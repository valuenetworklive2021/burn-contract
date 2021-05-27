
const { ethers } = require("hardhat");
const hre = require("hardhat");

const tokenAddress = process.env.TOKEN_ADDRESS;

async function main() {
  const signers = await ethers.getSigners();
  const { address } = signers[0];
  console.log("Args for Token contract ", address);

  if (!tokenAddress) {
    const ERC20Token = await hre.ethers.getContractFactory("CustomERC20");
    const erc20Token = await ERC20Token.deploy(address, address);

    await erc20Token.deployed();
    console.log("erc20Token deployed to:", erc20Token.address);

    tokenAddress = erc20Token.address;
  }

  const Burn = await hre.ethers.getContractFactory("Burn");
  const burn = await Burn.deploy(tokenAddress);

  await burn.deployed();

  console.log("burn deployed to:", burn.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
