// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract LitProtocolOG is ERC721, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    string public baseURI;

    constructor() ERC721("Lit Protocol OG", "LITOG") {}

    function safeMint(address to) public onlyOwner returns (uint256) {
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
}