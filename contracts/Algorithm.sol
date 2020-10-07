// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2; // 実験ライブラリらしい


contract Algorithm {
    // Web3にレポートのダウンロード数、アカウントの情報をEthereumから取ってくるように命令
    // 一旦、簡易的なデータを作ってアルゴリズムを実装する
    struct Report {
        string userAddress;
        string reportHash;
        uint16 downloads;
    }

    struct Hash {
        string reportHash;
        uint256 RP1;
    }

    Report[] public reports;
    Report[] public reportsAbove;
    Report[] public reportsBelow;
    Hash[] public reportsRp;

    constructor() public {
        reports.push(Report("0xc9472850C2bbEBC689b581b92A2E1A694235c9e5", "R1", 600));
        reports.push(Report("0x45c79bbE964d68beC3c8BeCAB9d3A7b7f7e9dDcd", "R2", 700));
        reports.push(Report("0xA4682e519519f3D461DEEa60ed8f2A07d7ed7458", "R3", 800));
        reports.push(Report("0x1FC6F20f2296628a7663902144Fc2D4507cCb5BD", "R4", 400));
        reports.push(Report("0x703f3570f9E4cE14a9bcD4082E6f099c74033421", "R5", 500));
        reports.push(Report("0x82400A6a62150Dc6a29B966b5322b35069a9484d", "R6", 900));
        reports.push(Report("0x41f3307e3693FcC9AAECa1d877B992b27B14950f", "R7", 100));
        reports.push(Report("0x82C9EE99802C077F2BB13E0Fb391753dF875aC31", "R8", 200));
        reports.push(Report("0xDC65E1106A1123fc00851D2e9CD8a5eDcd911afE", "R9", 300));
        reports.push(Report("0x1B01Da83f3053D7BE8D06Aaf9a0A0f62EaBB6c53", "R10", 50));
    }

    // HPF():High Pass Filter
    function HPF() public returns (Hash[] memory) {
        uint16 _median = 0;
        uint256 _n = reports.length;
        uint256 _a = 0;

        // 中央値を求める処理
        Report[] memory sortReports = reports;
        bubbleSort(sortReports);     // ダウンロード数順にソート
        if (_n % 2 == 0) {
            _median = (sortReports[_n/2 - 1].downloads + sortReports[_n/2].downloads) / 2;
        } else {
            _median = sortReports[_n/2].downloads;
        }
        
        // 中央値以上/未満でレポートを分ける
        for (uint i = 0; i < _n; i++) {
            if (sortReports[i].downloads >= _median) {
                reportsAbove.push(Report(sortReports[i].userAddress, sortReports[i].reportHash, sortReports[i].downloads));
            } else {
                reportsBelow.push(Report(sortReports[i].userAddress, sortReports[i].reportHash, sortReports[i].downloads));
            }
        }

        // 評価の傾斜をかける処理
        // 中央値以上のレポートには、レポートのダウンロード数が多い順にRPを与える
        _a = reportsAbove.length;
        if (_a <= 8) {
            for (uint i = 0; i < _a; i++) {
                reportsRp.push(Hash(reportsAbove[i].reportHash, 4 - i/2));
            }
        } else {
            for (uint i = 0; i < _a; i++) {
                reportsRp.push(Hash(reportsAbove[i].reportHash, 4 - 4*i/_a));
            }
        }
        // 中央値未満のレポートはRP=0
        for (uint i = 0; i < reportsAbove.length; i++) {
            reportsRp.push(Hash(reportsBelow[i].reportHash, 0));
        }
        
        return reportsRp;
    }

    // swap関数
    function swap(Report[] memory items, uint l, uint r) private pure {
        Report memory t = items[l];
        items[l] = items[r];
        items[r] = t;
    }

    // バブルソート(降順)
    function bubbleSort(Report[] memory items) public pure {
        uint length = items.length;
        for(uint i = 0; i < length-1; i++) {
            for(uint j = i; j <length; j++) {
                if(items[j].downloads > items[i].downloads) {
                    swap(items, i, j);
                }
            } 
        }
    }

    function reportsPush(string memory _user, string memory _reporthash, uint16 _downloads) public {
        reports.push(Report(_user, _reporthash, _downloads));
    }
}
