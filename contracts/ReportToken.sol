// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ReportToken is ERC20 {

  //event setup
  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);

  //mapping
  mapping(address => uint256) public balances;
  mapping(address => mapping(address => uint256)) public allowed;
  mapping(address => uint256) public userBalance;

//  string public constant name = 'ReportToken';
//  string public constant symbol = 'RPT';

  constructor(uint initialSupply) public ERC20 ('ReportToken', 'RPT'){
    _mint(msg.sender, initialSupply);
  }

  //トークン購入時に呼び出される関数
  //コントラクトのアドレスがETHを受け付けるようにする
  //purchase Token
  function purchaseToken(address _user, uint256 _balance) public payable returns (bool){
    _mint(_user, _balance);
    userBalance[_user] += _balance;
    return true;
  }


  //リワード送金時に呼び出される関数
  // withdraw関数
  //Todo
  function withdraw(address _user, uint withdraw_amount) public {

    //引き出し額を制限する
    require(withdraw_amount <= 0.1 ether);
    require(this.balance >= withdraw_amount,
      "Insufficient balance in reward for withdrawal request");

    //リクエストしたアドレスにその金額を送る
    _user.transfer(_user,withdraw_amount);
    emit withdraw(_user, withdraw_amount);
  }

  //レポート購入時に呼び出される関数
  //購入者のアドレスから供給者へトークンを送信する
  //Transfer function
  function transfer(address _to, uint256 _value) public payable override returns (bool) {
    require(balances[msg.sender] >= _value);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    emit Transfer(msg.sender, _to, _value);
    return true;
  }
  //Approve function
  function approve(address _spender, uint256 _value) public override returns (bool) {
    //allowance
    allowed[msg.sender][_spender] = _value;
    //Approval event
    emit Approval(msg.sender, _spender, _value);

    return true;
  }
  //tranferFrom function
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
