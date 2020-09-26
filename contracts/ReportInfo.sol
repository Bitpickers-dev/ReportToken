pragma solidity ^0.6.0;

contract ReportInfo{
    string reportHash;
    struct Report {
        string userAddress;
        string reportHash;
        uint16 downloads;
    }
    Report[] public Reports;

    function set(string memory _userAddress,string memory _reportHash,uint16 _downloads) public {
        
        Reports.push(Report(_userAddress,_reportHash,_downloads));
    }

    function get(uint _index) public view returns (string memory,string memory,uint16) {
        return (Reports[_index].userAddress, Reports[_index].reportHash, Reports[_index].downloads);
    }
}