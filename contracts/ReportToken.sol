// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ReportToken is ERC20 {

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);

  mapping(address => uint256) public balances;
  mapping(address => mapping(address => uint256)) public allowed;

  constructor(uint initialSupply) public ERC20 ('ReportToken', 'RPT'){
    _mint(msg.sender, initialSupply);
  }

  function purchaseToken(address _to, uint256 _value) public payable returns (bool){
    _mint(_to, _value);
    balances[_to] += _value;
    return true;
  }

  function parseAddr(string memory _a) public pure returns (address payable _parsedAddress) {
    bytes memory tmp = bytes(_a);
    uint160 iaddr = 0;
    uint160 b1;
    uint160 b2;
    for (uint i = 2; i < 2 + 2 * 20; i += 2) {
      iaddr *= 256;
      b1 = uint160(uint8(tmp[i]));
      b2 = uint160(uint8(tmp[i + 1]));
      if ((b1 >= 97) && (b1 <= 102)) {
        b1 -= 87;
      } else if ((b1 >= 65) && (b1 <= 70)) {
        b1 -= 55;
      } else if ((b1 >= 48) && (b1 <= 57)) {
        b1 -= 48;
      }
      if ((b2 >= 97) && (b2 <= 102)) {
        b2 -= 87;
      } else if ((b2 >= 65) && (b2 <= 70)) {
        b2 -= 55;
      } else if ((b2 >= 48) && (b2 <= 57)) {
        b2 -= 48;
      }
      iaddr += (b1 * 16 + b2);
    }
    return address(iaddr);
  }

  function withdraw(string memory userAddress) public {
    address payable _to = parseAddr(userAddress);
    _to.transfer(1000000000000000000);
  }

  function approve(address _spender, uint256 _value) public override returns (bool) {
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  function transferFrom(address _from, address _to, uint256 _value) public override returns (bool) {

    require(_value <= balances[_from]);
    require(_value <= allowed[_from][msg.sender]);

    balances[_from] -= _value;
    balances[_to] += _value;

    allowed[_from][msg.sender] -= _value;

    emit Transfer(_from, _to, _value);
    return true;
  }
}
