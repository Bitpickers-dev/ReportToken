// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

contract Algorithm {

  struct Report {string userAddress;string reportHash;uint16 downloads;}

  struct User {address userAddress;uint8 purchasedTokenAmount;}

  struct RP1Table {address userAddress;uint8 RP1;}

  struct RP2Table {address userAddress; uint8 RP2;}
  //
  Report[] public  reports;
  User[] public   users;
  RP1Table [] public RP1Array;
  RP2Table [] public RP2Array;

  mapping(uint8 => User) public userMapping;
  //
  constructor() public {
    //    //RP1用のデータ
    //    reports.push(Report("0xc9472850C2bbEBC689b581b92A2E1A694235c9e5", "R1", 900));
    //    //    reports.push(Report("0x45c79bbE964d68beC3c8BeCAB9d3A7b7f7e9dDcd", "R2", 800));
    //    //    reports.push(Report("0xA4682e519519f3D461DEEa60ed8f2A07d7ed7458", "R3", 700));
    //    //    reports.push(Report("0x1FC6F20f2296628a7663902144Fc2D4507cCb5BD", "R4", 600));
    //    //    reports.push(Report("0x703f3570f9E4cE14a9bcD4082E6f099c74033421", "R5", 500));
    //    //    reports.push(Report("0x82400A6a62150Dc6a29B966b5322b35069a9484d", "R6", 400));
    //    //    reports.push(Report("0x41f3307e3693FcC9AAECa1d877B992b27B14950f", "R7", 300));
    //    //    reports.push(Report("0x82C9EE99802C077F2BB13E0Fb391753dF875aC31", "R8", 200));
    //    //    reports.push(Report("0xDC65E1106A1123fc00851D2e9CD8a5eDcd911afE", "R9", 100));
    //    //    reports.push(Report("0x1B01Da83f3053D7BE8D06Aaf9a0A0f62EaBB6c53", "R21", 50));
    //
    //RP2用のデータ(連想配列)
    userMapping[0].userAddress = 0xc9472850C2bbEBC689b581b92A2E1A694235c9e5;
    userMapping[0].purchasedTokenAmount = 100;
    userMapping[1].userAddress = 0x45c79bbE964d68beC3c8BeCAB9d3A7b7f7e9dDcd;
    userMapping[1].purchasedTokenAmount = 90;
    userMapping[2].userAddress = 0xA4682e519519f3D461DEEa60ed8f2A07d7ed7458;
    userMapping[2].purchasedTokenAmount = 80;
    userMapping[3].userAddress = 0x1FC6F20f2296628a7663902144Fc2D4507cCb5BD;
    userMapping[3].purchasedTokenAmount = 70;
    userMapping[4].userAddress = 0x703f3570f9E4cE14a9bcD4082E6f099c74033421;
    userMapping[4].purchasedTokenAmount = 60;
    userMapping[5].userAddress = 0x82400A6a62150Dc6a29B966b5322b35069a9484d;
    userMapping[5].purchasedTokenAmount = 50;
    userMapping[6].userAddress = 0x41f3307e3693FcC9AAECa1d877B992b27B14950f;
    userMapping[6].purchasedTokenAmount = 40;
    userMapping[7].userAddress = 0x82C9EE99802C077F2BB13E0Fb391753dF875aC31;
    userMapping[7].purchasedTokenAmount = 30;
    userMapping[8].userAddress = 0xDC65E1106A1123fc00851D2e9CD8a5eDcd911afE;
    userMapping[8].purchasedTokenAmount = 20;
    userMapping[9].userAddress = 0x1B01Da83f3053D7BE8D06Aaf9a0A0f62EaBB6c53;
    userMapping[9].purchasedTokenAmount = 10;
  }
  //
  //  // HPF():High Pass Filter
  //  //  function HPF() public view {
  //  //    uint16 _median = 0;
  //  //    uint256 n = 4;
  //  //
  //  //    if (n % 2 == 0) {
  //  //      _median = (reports[n / 2 - 1].downloads + reports[n / 2].downloads) / 2;
  //  //    }
  //  //
  //  //    else {
  //  //      _median = reports[n / 2].downloads;
  //  //    }
  //  //    return _median;
  //  //  }
  //
  //  //RP2の雛形
  //  function RP2() internal returns (RP2Table[] memory){
  //    uint8[5] memory rp2Receiver;
  //    uint16 _totalIssuance;
  //    //    アドレスごとのトークン発行量を計算
  //    for (uint8 i = 0; i < 10; i++) {
  //      _totalIssuance += userMapping[i].purchasedTokenAmount;
  //    }
  //
  //    //ルーレットで当選者を5回きめる(数字はてきとー)
  //    for (uint8 j = 0; j < 5; j++) {
  //      uint8 _hitNumber = random();
  //      rp2Receiver[j] = roulette(_hitNumber, _totalIssuance);
  //      for (uint8 i = 0; i < 10; i++) {
  //        if (i == rp2Receiver[j]) break;
  //        {
  //          address _receiverAddress = userMapping[i].userAddress;
  //          uint8 point = 0;
  //          point += 1;
  //          RP2Array.push(RP2Table(_receiverAddress, point));
  //        }
  //      }
  //    }
  //    return RP2Array;
  //  }
  //
  //  //乱数生成
  //  function random() internal pure returns (uint8 randomNumber){
  //    //TODO:4
  //    //TODO:5
  //    return 0;
  //  }

  //ルーレット
  //TODO:実装に不備あり(毎回10を返す)
  function roulette(uint8 hitNumber, uint16 totalIssuance) public view returns (uint16 winner){
    //    uint16 _rangeMin;
    //    uint16 _rangeMax;
    uint16 _percentage;
    uint8 k;

    for (k = 0; k < 10; k++) {
      _percentage = 100 * userMapping[k].purchasedTokenAmount / totalIssuance;
      _rangeMax += _percentage;
      if (_rangeMin <= hitNumber && _rangeMax >= hitNumber) {
        return k;
      } else {
        _rangeMin = _rangeMax;
      }
    }
  }
}
