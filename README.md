# CryptoFin Solidity
A collection of Solidity libraries.


# To Do
Generic map and reduce with bytes32[]?

    function map(bytes32[] memory A, function (bytes32) pure returns (bytes32) fn);
    function reduce(bytes32[] memory A, function (bytes32, bytes32) pure returns (bytes32) fn);

Then just write functions that operate on them eg.

    function doubleUInt256(bytes32) returns (bytes32);

    function addUInt256(bytes32, bytes32) returns (bytes32);
    function addUInt128(bytes32, bytes32) returns (bytes32);
    function mulUInt256(bytes32, bytes32) returns (bytes32);
    function divUInt256(bytes32, bytes32) returns (bytes32);

    // Rational128
    function computePercentageRational128(bytes32, bytes32) returns (bytes32);

