// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract EFROG is ERC721URIStorage {
    uint256 private _tokenIdCounter;
    address immutable owner;

    constructor() ERC721("MockEFROG", "mEFROG") {
        owner = msg.sender;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "https://example.com/metadata/";
    }

    function mint(address recipient, string memory tokenURI) public onlyOwner returns (uint256) {
        uint256 newItemId = _tokenIdCounter;
        _safeMint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);
        _tokenIdCounter += 1;
        return newItemId;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not Authorized");
        _;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}