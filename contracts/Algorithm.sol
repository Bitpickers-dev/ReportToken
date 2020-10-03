pragma solidity ^0.6.0;


contract Algorithm {
    // Web3にレポートのダウンロード数、アカウントの情報をEthereumから取ってくるように命令
    // 一旦、簡易的なデータを作ってアルゴリズムを実装する
    struct Report {
        string userAddress;
        string reportHash;
        uint16 downloads;
    }
    Report[] public reports;
    
    constructor() public{
        reports.push(Report("0xc9472850C2bbEBC689b581b92A2E1A694235c9e5", "R1", 900));
        reports.push(Report("0x45c79bbE964d68beC3c8BeCAB9d3A7b7f7e9dDcd", "R2", 800));
        reports.push(Report("0xA4682e519519f3D461DEEa60ed8f2A07d7ed7458", "R3", 700));
        reports.push(Report("0x1FC6F20f2296628a7663902144Fc2D4507cCb5BD", "R4", 600));
        // reports.push(Report("0x703f3570f9E4cE14a9bcD4082E6f099c74033421", "R5", 500));
        // reports.push(Report("0x82400A6a62150Dc6a29B966b5322b35069a9484d", "R6", 400));
        // reports.push(Report("0x41f3307e3693FcC9AAECa1d877B992b27B14950f", "R7", 300));
        // reports.push(Report("0x82C9EE99802C077F2BB13E0Fb391753dF875aC31", "R8", 200));
        // reports.push(Report("0xDC65E1106A1123fc00851D2e9CD8a5eDcd911afE", "R9", 100));
        // reports.push(Report("0x1B01Da83f3053D7BE8D06Aaf9a0A0f62EaBB6c53", "R21", 50));
    }



    // HPF():High Pass Filter
    function HPF() public view returns (uint16) {
        uint16 _median = 0;
        uint256 n = 4;

        if (n % 2 == 0) {
            _median = (reports[n/2 - 1].downloads + reports[n/2].downloads) / 2;
        }

        else {
            _median = reports[n/2].downloads;
        }
        return _median;
    }

    function reportsPush(string memory _user, string memory _reporthash, uint16 _downloads) public {
        reports.push(Report(_user, _reporthash, _downloads));
    }
}

