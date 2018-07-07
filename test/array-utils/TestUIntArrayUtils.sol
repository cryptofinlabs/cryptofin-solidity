pragma solidity ^0.4.18;


import "truffle/Assert.sol";

import "../../contracts/array-utils/UIntArrayUtils.sol";


contract TestUIntArrayUtils {
  using UIntArrayUtils for uint[];

  // TODO: use safemath
  /// @dev Simple function for testing
  function square(uint n) internal pure returns (uint) {
      return n * n;
  }

  function add(uint a, uint b) internal pure returns (uint) {
      return a + b;
  }

  function testMap() public {
      // Cast first element to uint to avoid auto casting to uint8
      // uint[] memory a = [uint(1), 4, 5, 3, 5];
      uint[] memory a = new uint[](5);
      a[0] = 1;
      a[1] = 4;
      a[2] = 5;
      a[3] = 3;
      a[4] = 5;
      uint[] memory r = a.map(square);
      Assert.equal(a.length, r.length, "mapped array is of same length");
      Assert.equal(r[0], 1, "element 0 matches");
      Assert.equal(r[1], 16, "element 1 matches");
      Assert.equal(r[2], 25, "element 2 matches");
      Assert.equal(r[3], 9, "element 3 matches");
      Assert.equal(r[4], 25, "element 4 matches");
  }

  function testMapEmpty() public {
      uint[] memory a = new uint[](0);
      uint[] memory r = a.map(square);
      Assert.equal(r.length, 0, "mapped array length is 0");
  }

  function testReduce() public {
      // uint[] memory a = [uint(1), 2, 3, 4, 5, 6, 7, 8, 9];
      uint[] memory a = new uint[](9);
      a[0] = 9;
      a[1] = 2;
      a[2] = 7;
      a[3] = 4;
      a[4] = 5;
      a[5] = 6;
      a[6] = 3;
      a[7] = 8;
      a[8] = 1;
      uint r = a.reduce(add);
      Assert.equal(r, 45, "reduce produces correct value");
      // TODO: check not mutated
  }

}
