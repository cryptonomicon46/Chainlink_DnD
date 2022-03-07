// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

// import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";


// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


contract DungeonsAndDragon is ERC721, VRFConsumerBase {
    using SafeMath for uint256;
    using Strings for string;
    bytes32 internal keyHash;
    uint256 public randomResult;
    address public VRFCoordinator;
    uint256 internal fee;
    address public LinkToken;
    uint64  private s_subscriptionId = 773;

  struct Character {
        uint256 strength;
        uint256 dexterity;
        uint256 constitution;
        uint256 intelligence;
        uint256 wisdom;
        uint256 charisma;
        uint256 experience;
        string name;
    }

    Character[] public characters;

    mapping(bytes32 => string) requestToCharacterName;
    mapping(bytes32 => address) requestToSender;
    mapping(bytes32 => uint256) requestToTokenId;
    mapping(uint256 => string) private _tokenURIs;


    /**
     * Constructor inherits VRFConsumerBase
     *
     * Network: Rinkeby
     VrfcoordinatorV1: 0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B
     LinkToken (V1/V2): 0x01BE23585060835E02B77ef475b0Cc51aA1e0709
     KeyHash: 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311
     */


     /* Network: KOVAN
     VrfCoordinatorV1: 0xdD3782915140c8f3b190B5D67eAc6dc5760C46E9
     LinkToken: 0xa36085F69e2889c224210F603D836748e7dC0088
     KeyHash: 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4
    fee: 0.1 LINK

     */


  constructor(address _VRFCoordinator, address _LinkToken, bytes32 _keyHash )  
//   VRFConsumerBaseV2(_VRFCoordinator, _LinkToken)
    VRFConsumerBase(_VRFCoordinator, _LinkToken)

  ERC721 ("DungeonsAndDragons","D&D") 

   {   

       VRFCoordinator  = _VRFCoordinator;
       LinkToken = _LinkToken;
       keyHash = _keyHash;
       fee = 0.1 * 10**18; // 0.1Link
  }
 function requestNewRandomCharacter(
        string memory name
    ) public returns (bytes32) {
        require(
            LINK.balanceOf(address(this)) >= fee,
            "Not enough LINK - fill contract with faucet"
        );
        bytes32 requestId = requestRandomness(keyHash, fee);
        requestToCharacterName[requestId] = name;
        requestToSender[requestId] = msg.sender;
        return requestId;
    }

     function fulfillRandomness(bytes32 requestId, uint256 randomNumber)
        internal
        override
    {
        uint256 newId = characters.length;
        uint256 strength = (randomNumber % 100);
        uint256 dexterity = ((randomNumber % 10000) / 100 );
        uint256 constitution = ((randomNumber % 1000000) / 10000 );
        uint256 intelligence = ((randomNumber % 100000000) / 1000000 );
        uint256 wisdom = ((randomNumber % 10000000000) / 100000000 );
        uint256 charisma = ((randomNumber % 1000000000000) / 10000000000);
        uint256 experience = 0;

        characters.push(
            Character(
                strength,
                dexterity,
                constitution,
                intelligence,
                wisdom,
                charisma,
                experience,
                requestToCharacterName[requestId]
            )
        );
        _safeMint(requestToSender[requestId], newId);
    }


    function getLevel(uint256 tokenId) public view returns (uint256) {
        return sqrt(characters[tokenId].experience);
    }

    function getNumberOfCharacters() public view returns (uint256) {
        return characters.length; 
    }

    function getCharacterOverView(uint256 tokenId)
        public
        view
        returns (
            string memory,
            uint256,
            uint256,
            uint256
        )
    {
        return (
            characters[tokenId].name,
            characters[tokenId].strength + characters[tokenId].dexterity + characters[tokenId].constitution + characters[tokenId].intelligence + characters[tokenId].wisdom + characters[tokenId].charisma,
            getLevel(tokenId),
            characters[tokenId].experience
        );
    }
//     function getTokenURI(uint256 tokenId) public view returns (string memory) {
//         return tokenURI(tokenId);
//     }

//    function _baseURI(string memory _tokenURI) internal pure  returns (string memory) {
//         return _tokenURI;
//     }
  function gettokenURI(uint256 tokenId) public view  returns (string memory) {
        require(_exists(tokenId), "ERC721URIStorage: URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];
        // string memory base = _baseURI();

        // If there is no base URI, return the token URI.
        // if (bytes(base).length == 0) {
        //     return _tokenURI;
        // }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        // if (bytes(_tokenURI).length > 0) {
        //     return string(abi.encodePacked(base, _tokenURI));
        // }
        return _tokenURI;
        // return super.tokenURI(tokenId);
    }


    function setTokenURI(uint256 tokenId, string memory _tokenURI) public {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: transfer caller is not owner nor approved"
        );
        _setTokenURI(tokenId, _tokenURI);
    }

    /**
     * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    
    function sqrt(uint256 x) internal pure returns (uint256 y) {
        uint256 z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }


}
