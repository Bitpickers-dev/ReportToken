// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ReportToken is ERC20 {

  event Transfer(address indexed _from, address indexed _to, uint256 _value);

  mapping(address => uint256) public balances;

  constructor(uint initialSupply) public ERC20 ('ReportToken', 'RPT'){
    _mint(msg.sender, initialSupply);
  }

  function purchaseToken(address _to, uint256 _value) public payable returns (bool){
    _mint(_to, _value);
    balances[_to] += _value;
    return true;
  }

  function withdraw(string memory userAddress) public {
    address payable _to = parseAddr(userAddress);
    _to.transfer(1000000000000000000);
  }
}
