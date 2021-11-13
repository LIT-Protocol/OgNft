// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract LitProtocolOG is ERC721, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;

    Counters.Counter private _tokenIdCounter;
    string public baseURI;
    string public contractMetadataURI;
    uint public maxMintable = 10000;

    constructor() ERC721("Lit Genesis Gate", "LITGATE") {
        baseURI = "https://arweave.net/xO4J8LHLff1ja6Zf9j5H8icvtYL3KKk2m5_tr-Ls34g/";
    }

    function batchMint(uint256 amount) public onlyOwner {
        for(uint256 i = 0; i < amount; i++){
            safeMint(owner());
        }
    }

    function safeMint(address to) public onlyOwner returns (uint256) {
        require(_tokenIdCounter.current() < maxMintable, "All tokens have already been minted");
        _tokenIdCounter.increment();
        _safeMint(to, _tokenIdCounter.current());
        return _tokenIdCounter.current();
    }

    function setURI(string memory newURI) public onlyOwner {
        baseURI = newURI;
    }
    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }
    
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : "";
    }

    function setContractURI(string memory newURI) public onlyOwner {
        contractMetadataURI = newURI;
    }
    function contractURI() public view returns (string memory) {
        return contractMetadataURI;
    }
}