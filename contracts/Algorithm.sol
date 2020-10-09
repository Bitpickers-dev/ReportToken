// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;


contract Algorithm {
  // Web3にレポートのダウンロード数、アカウントの情報をEthereumから取ってくるように命令
  // 一旦、簡易的なデータを作ってアルゴリズムを実装する

  struct Report {
    string userAddress;
    string reportHash;
    uint16 downloads;
  }

  struct User {
    address userAddress;
    uint16 purchasedTokenAmount;
  }

  struct RP1Table {
    address userAddress;
    uint16 RP1;
  }

  struct RP2Table {
    address userAddress;
    uint16 RP2;
  }

  Report[] public  reports;
  User[] public   users;
  RP1Table [] public RP1Array;
  RP2Table [] public RP2Array;

  //  mapping(address => uint256) public User;

  constructor() public {
    //RP1用のデータ(レポートハッシュ、レポート名、DL数)
    reports.push(Report("0xc9472850C2bbEBC689b581b92A2E1A694235c9e5", "R1", 900));
    //    reports.push(Report("0x45c79bbE964d68beC3c8BeCAB9d3A7b7f7e9dDcd", "R2", 800));
    //    reports.push(Report("0xA4682e519519f3D461DEEa60ed8f2A07d7ed7458", "R3", 700));
    //    reports.push(Report("0x1FC6F20f2296628a7663902144Fc2D4507cCb5BD", "R4", 600));
    //    reports.push(Report("0x703f3570f9E4cE14a9bcD4082E6f099c74033421", "R5", 500));
    //    reports.push(Report("0x82400A6a62150Dc6a29B966b5322b35069a9484d", "R6", 400));
    //    reports.push(Report("0x41f3307e3693FcC9AAECa1d877B992b27B14950f", "R7", 300));
    //    reports.push(Report("0x82C9EE99802C077F2BB13E0Fb391753dF875aC31", "R8", 200));
    //    reports.push(Report("0xDC65E1106A1123fc00851D2e9CD8a5eDcd911afE", "R9", 100));
    //    reports.push(Report("0x1B01Da83f3053D7BE8D06Aaf9a0A0f62EaBB6c53", "R21", 50));

    //RP2の情報は別途用意する
    //RP2用のデータ(ユーザーアドレス、トークン購入量)
    //TODO:1:　データ構造をmappingに置き換える
    users.push(User(0xc9472850C2bbEBC689b581b92A2E1A694235c9e5, 100));
    //    users.push(User("0x45c79bbE964d68beC3c8BeCAB9d3A7b7f7e9dDcd", 90));
    //    users.push(User("0xA4682e519519f3D461DEEa60ed8f2A07d7ed7458", 80));
    //    users.push(User("0x1FC6F20f2296628a7663902144Fc2D4507cCb5BD", 70));
    //    users.push(User("0x703f3570f9E4cE14a9bcD4082E6f099c74033421", 60));
    //    users.push(User("0x82400A6a62150Dc6a29B966b5322b35069a9484d", 50));
    //    users.push(User("0x41f3307e3693FcC9AAECa1d877B992b27B14950f", 40));
    //    users.push(User("0x82C9EE99802C077F2BB13E0Fb391753dF875aC31", 30));
    //    users.push(User("0xDC65E1106A1123fc00851D2e9CD8a5eDcd911afE", 20));
    //    users.push(User("0x1B01Da83f3053D7BE8D06Aaf9a0A0f62EaBB6c53", 10));
    //    User[0xc9472850C2bbEBC689b581b92A2E1A694235c9e5] += 100;
  }

  // HPF():High Pass Filter
  //  function HPF() public view {
  //    uint16 _median = 0;
  //    uint256 n = 4;
  //
  //    if (n % 2 == 0) {
  //      _median = (reports[n / 2 - 1].downloads + reports[n / 2].downloads) / 2;
  //    }
  //
  //    else {
  //      _median = reports[n / 2].downloads;
  //    }
  //    return _median;
  //  }

  //RP2の雛形
  function RP2() internal returns (RP2Table[] memory){
    uint[5] memory rp2Receiver;
    uint256 _totalIssuance = 0;

    //アドレスごとのトークン発行量を計算
    for (uint i = 0; i < 10; i++) {
      _totalIssuance += users[i].purchasedTokenAmount;
    }

    //ルーレットで当選者を5回きめる(数字はてきとー)
    for (uint j = 0; j < 5; j++) {
      //    uint256 _hitNumber = random();
      uint256 _hitNumber = 15;
      rp2Receiver[j] = roulette(_hitNumber, _totalIssuance);

      for (uint i = 0; i < 10; i++) {
        if (i == rp2Receiver[j]) break;
        {
          address _receiverAddress = users[i].userAddress;
          uint16 point = 0;
          point += 1;
          RP2Array.push(RP2Table(_receiverAddress, point));
        }
      }
    }
    //　(当選者アドレス、RP2)を配列で
    //mappingは不可能
    return RP2Array;
  }

  //乱数生成
  function random() internal pure returns (uint8 randomNumber){
    //TODO:4
    //TODO:5
    return 0;
  }

  //ルーレット
  function roulette(uint256 hitNumber, uint256 totalIssuance) internal view returns (uint8 winner){
    uint256 _rangeMin = 0;
    uint256 _rangeMax = 0;
    //    uint256 _percentage = 0;
    uint8 k = 0;

    for (k = 0; k < 10; k++) {
      uint256 _percentage = (users[k].purchasedTokenAmount / totalIssuance) * 100;
      _rangeMax += _percentage;
      if (_rangeMin <= hitNumber && _rangeMax >= hitNumber) break;
      _rangeMin = _rangeMax;
    }
    //当選者番号を返す
    return k;
  }
}
