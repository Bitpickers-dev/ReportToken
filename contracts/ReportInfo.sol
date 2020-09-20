pragma solidity ^0.6.0;

contract ReportInfo{
    string reportHash;
    struct Report {
        string _reportHash;
    }
    Report[] public Reports;

    function set(string memory _reportHash) public {

        reportHash = _reportHash;
        Reports.push(Report(reportHash));
    }

    function get() public view returns (string memory) {
        return reportHash;
    }
}