pragma solidity ^0.4.18;


import "truffle/Assert.sol";

import "../../contracts/array-utils/UIntArrayUtils.sol";


contract TestUIntArrayUtils {
  using UIntArrayUtils for uint256[];

  uint256[] A;
  uint256[] B;

  function beforeEach() public {
    A.length = 0;
    B.length = 0;

    A.push(1);
    A.push(2);
    A.push(3);
    A.push(4);
  }

  // TODO: use safemath
  /// @dev Simple function for testing
  function square(uint256 n) internal pure returns (uint256) {
    return n * n;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    return a + b;
  }

  function isNonZero(uint256 n) internal pure returns (bool) {
    return n != 0;
  }

  function alwaysTrue(uint256) internal pure returns (bool) {
    return true;
  }

  function alwaysFalse(uint256) internal pure returns (bool) {
    return false;
  }

  function testMap() public {
    // Cast first element to uint256 to avoid auto casting to uint8
    // uint256[] memory a = [uint256(1), 4, 5, 3, 5];
    uint256[] memory a = new uint256[](5);
    a[0] = 1;
    a[1] = 4;
    a[2] = 5;
    a[3] = 3;
    a[4] = 5;
    uint256[] memory r = a.map(square);
    Assert.equal(a.length, r.length, "mapped array is of same length");
    Assert.equal(r[0], 1, "element 0 matches");
    Assert.equal(r[1], 16, "element 1 matches");
    Assert.equal(r[2], 25, "element 2 matches");
    Assert.equal(r[3], 9, "element 3 matches");
    Assert.equal(r[4], 25, "element 4 matches");
  }

  function testMapEmpty() public {
    uint256[] memory a = new uint256[](0);
    uint256[] memory r = a.map(square);
    Assert.equal(r.length, 0, "mapped array length is 0");
  }

  function testReduce() public {
    // uint256[] memory a = [uint256(1), 2, 3, 4, 5, 6, 7, 8, 9];
    uint256[] memory a = new uint256[](9);
    a[0] = 9;
    a[1] = 2;
    a[2] = 7;
    a[3] = 4;
    a[4] = 5;
    a[5] = 6;
    a[6] = 3;
    a[7] = 8;
    a[8] = 1;
    uint256 r = a.reduce(add);
    Assert.equal(r, 45, "reduce produces correct value");
    // TODO: check not mutated
  }

  function testFilterNonZero() public {
    uint256[] memory a = new uint256[](9);
    a[0] = 0;
    a[1] = 2;
    a[2] = 0;
    a[3] = 4;
    a[4] = 5;
    a[5] = 0;
    a[6] = 3;
    a[7] = 0;
    a[8] = 1;
    uint256[] memory filtered = a.filter(isNonZero);
    Assert.equal(filtered.length, 5, "filtered array length is 5");
    Assert.equal(filtered[0], 2, "element 0 matches");
    Assert.equal(filtered[1], 4, "element 1 matches");
    Assert.equal(filtered[2], 5, "element 2 matches");
    Assert.equal(filtered[3], 3, "element 3 matches");
    Assert.equal(filtered[4], 1, "element 4 matches");
  }

  function testFilterNone() public {
    uint256[] memory filtered = A.filter(alwaysTrue);
    Assert.equal(filtered.length, 4, "filtered array length is 4");
    Assert.equal(filtered[0], 1, "element 0 matches");
    Assert.equal(filtered[1], 2, "element 1 matches");
    Assert.equal(filtered[2], 3, "element 2 matches");
    Assert.equal(filtered[3], 4, "element 3 matches");
  }

  function testFilterAll() public {
    uint256[] memory filtered = A.filter(alwaysFalse);
    Assert.equal(filtered.length, 0, "filtered array length is 0");
  }

}
