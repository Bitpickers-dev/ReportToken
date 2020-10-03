// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract ReportInfo{
    //mapping
    mapping(address => uint16) public reportId;
    mapping(address => mapping(uint16 => string)) public reports;


    //レポートを共有した時に呼び出される関数
    //引数はレポートのハッシュ値
    //set
    function setReport(string memory _reportHash) public returns(uint16){
        reportId[msg.sender]++;
        reports[msg.sender][reportId[msg.sender]] = _reportHash;
        return reportId[msg.sender];
    }

    //自分が共有したレポートを見る時の関数
    //引数はレポートのID(インデックス)
    //get owner report
    function getOwnerReport(uint16 _index) public view returns (string memory) {
        return reports[msg.sender][_index];
    }

    //購入したレポートを見る時の関数
    //引数はレポートのID(インデックス)とそのレポートをシェアしたアカウントのアドレス
    //get report
    function getReport(uint16 _index,address _shareAddress) public view returns (string memory){
        return reports[_shareAddress][_index];
    }
}
