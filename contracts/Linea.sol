// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "./tCROAK.sol";
import "./EFROG.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";

contract Linea {
    address immutable owner;

    IERC20 private CROAK;
    EFROG private EFROG_CONTRACT;
    bytes32 private secret;

    uint256 public  constant SPIN_FEES = 20;

    string[] private efrogs = [
    "https://rose-melodic-felidae-510.mypinata.cloud/ipfs/QmVoBU1jhYgUfXuFVka9UaakZjtiNv53S3eFTquV9a8Zxu/2.json",
    "https://rose-melodic-felidae-510.mypinata.cloud/ipfs/QmVoBU1jhYgUfXuFVka9UaakZjtiNv53S3eFTquV9a8Zxu/4.json",
    "https://rose-melodic-felidae-510.mypinata.cloud/ipfs/QmVoBU1jhYgUfXuFVka9UaakZjtiNv53S3eFTquV9a8Zxu/6.json",
    "https://rose-melodic-felidae-510.mypinata.cloud/ipfs/QmVoBU1jhYgUfXuFVka9UaakZjtiNv53S3eFTquV9a8Zxu/3.json",
    "https://rose-melodic-felidae-510.mypinata.cloud/ipfs/QmVoBU1jhYgUfXuFVka9UaakZjtiNv53S3eFTquV9a8Zxu/5.json",
    "https://rose-melodic-felidae-510.mypinata.cloud/ipfs/QmVoBU1jhYgUfXuFVka9UaakZjtiNv53S3eFTquV9a8Zxu/1.json"
    ];

    event LevelCompleted(address indexed sender, uint256 level);
    event RewardedNFT(address indexed receiver, uint256 efrogTYPE);

    constructor() {
        owner = msg.sender;
        CROAK = new tCROAK();
        EFROG_CONTRACT = new EFROG();
    }

    function spin() public {

        bool success = CROAK.transferFrom(msg.sender, address(this), SPIN_FEES * (10**18));
        require(success, "Transfer Unsuccessful");
    }

    function distributeRewards(bytes32 hashed, uint256 data, uint256 efrogTYPE, address sender, uint256 level) public {
        bytes32 calculatedHash = keccak256(abi.encodePacked(data, secret, efrogTYPE, sender, level));
        require(hashed == calculatedHash, "Invalid Hash");
        if (data == 0) {
            croakReward(sender, 20*(10**18));

            emit LevelCompleted(sender, level);
        } else if (data == 1) {
            croakReward(sender, 10*(10**18));
        } else if (data == 2) {
            croakReward(sender, 30*(10**18));
        } else if (data == 3) {
            efrogsReward(sender, efrogTYPE);
        }
    }

    function efrogsReward(address to, uint256 efrogTYPE) internal {
        EFROG_CONTRACT.mint(to, efrogs[efrogTYPE]);
        emit RewardedNFT(to, efrogTYPE);
    }

    function croakReward(address to, uint256 amount) internal {
        require(CROAK.transfer(to, amount), "Transfer Unsuccessful");
    }
    function setSecret(bytes32 _secret) public onlyOwner {
        secret = _secret;
    }

    function faucet() public {
        bool success = CROAK.transfer(msg.sender, SPIN_FEES * (10**18));
        require(success, "Transfer Unsuccessful");
    }

    function balanceOf(address account) external view returns (uint256) {
        return CROAK.balanceOf(account);
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Not Authorized");
        _;
    }
}