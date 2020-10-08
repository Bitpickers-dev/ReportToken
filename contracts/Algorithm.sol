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

    struct RP1Table {
        string userAddress;
        uint256 RP1;
    }

    Report[] public reports;
    Report[] public reportsAbove;
    Report[] public reportsBelow;
    RP1Table[] public RP1Array;

    constructor() public {
        reports.push(Report("0xc9472850C2bbEBC689b581b92A2E1A694235c9e5", "R1", 600));
        reports.push(Report("0xc9472850C2bbEBC689b581b92A2E1A694235c9e5", "R2", 700));
        reports.push(Report("0xc9472850C2bbEBC689b581b92A2E1A694235c9e5", "R3", 800));
        reports.push(Report("0x45c79bbE964d68beC3c8BeCAB9d3A7b7f7e9dDcd", "R4", 400));
        reports.push(Report("0x45c79bbE964d68beC3c8BeCAB9d3A7b7f7e9dDcd", "R5", 500));
        reports.push(Report("0x45c79bbE964d68beC3c8BeCAB9d3A7b7f7e9dDcd", "R6", 900));
        reports.push(Report("0xA4682e519519f3D461DEEa60ed8f2A07d7ed7458", "R7", 100));
        reports.push(Report("0xA4682e519519f3D461DEEa60ed8f2A07d7ed7458", "R8", 200));
        reports.push(Report("0xA4682e519519f3D461DEEa60ed8f2A07d7ed7458", "R9", 300));
        reports.push(Report("0x1FC6F20f2296628a7663902144Fc2D4507cCb5BD", "R10", 50));
    }

    // HPF():High Pass Filter
    function HPF() public returns (RP1Table[] memory) {
        uint16 _median = 0;
        uint256 n = reports.length;
        uint256 _numOfAbove = 0;

        // 中央値を求める処理
        Report[] memory sortReports = reports;
        bubbleSort(sortReports);     // ダウンロード数順にソート
        if (n % 2 == 0) {
            _median = (sortReports[n/2 - 1].downloads + sortReports[n/2].downloads) / 2;
        } else {
            _median = sortReports[n/2].downloads;
        }
        
        // 中央値以上/未満でレポートを分ける
        for (uint i = 0; i < n; i++) {
            if (sortReports[i].downloads >= _median) {
                reportsAbove.push(Report(sortReports[i].userAddress, sortReports[i].reportHash, sortReports[i].downloads));
            } else {
                reportsBelow.push(Report(sortReports[i].userAddress, sortReports[i].reportHash, sortReports[i].downloads));
            }
        }

        // 評価の傾斜をかける処理
        // 中央値以上のレポートには、レポートのダウンロード数が多い順にRPを与える
        // RPはアドレスごとに集計する
        _numOfAbove = reportsAbove.length;
        if (_numOfAbove <= 8) {
            for (uint i = 0; i < _numOfAbove; i++) {
                RP1Array.push(RP1Table(reportsAbove[i].reportHash, 40 - 5*i));
            }
        } else {
            for (uint i = 0; i < _numOfAbove; i++) {
                RP1Array.push(RP1Table(reportsAbove[i].reportHash, 40 - 40*i/_numOfAbove));
            }
        }
        // 中央値未満のレポートはRP=0
        for (uint i = 0; i < reportsAbove.length; i++) {
            RP1Array.push(RP1Table(reportsBelow[i].userAddress, 0));
        }
        
        return RP1Array;
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
}
