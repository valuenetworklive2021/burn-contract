pragma solidity ^0.7.9;

contract Burn {
    address private owner;
    address private tokenContract;

    struct OwnerData {
        address user;
        uint256 value;
    }

    mapping(address => OwnerData) private ownerList;

    constructor(address tokenContractAddress) public {
        owner = msg.sender;
        ownerList[owner] = OwnerData(msg.sender, 0);
        tokenContract = tokenContractAddress;
    }

    modifier _isOwner() {
        require(owner == msg.sender, "Only Owner Allowed");
        _;
    }

    modifier _isTokenContract(address contractAddress) {
        require(
            tokenContract == contractAddress,
            "Only Token Contract Call Allowed"
        );
        _;
    }

    /*
     *Function to stake token in owner contract
     * Only Token contract can stake token in this contract
     */

    function stakeToken(uint256 amount) public _isTokenContract(msg.sender) {
        require(amount > 0, "Amount should be greater than 0");
        ownerList[owner].value += amount;
    }

    /*
     *Function to update Token contract address
     */
    function updateTokenContract(address newTokenContract)
        public
        _isOwner()
        returns (bool)
    {
        tokenContract = newTokenContract;
    }

    // Returns Total Token staked at Owner Account
    function balance() public view returns (uint256) {
        return ownerList[owner].value;
    }
}
