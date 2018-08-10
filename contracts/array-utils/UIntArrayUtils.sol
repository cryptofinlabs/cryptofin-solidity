pragma solidity ^0.4.18;


// Functions use i++ because overflowing a uint256 by iteration isn't a concern
library UIntArrayUtils {

  function map(uint256[] memory A, function(uint256) pure returns (uint256) fn)
    internal
    pure
    returns (uint256[] memory)
  {
    uint256[] memory mapped = new uint256[](A.length);
    for (uint256 i = 0; i < A.length; i++) {
      mapped[i] = fn(A[i]);
    }
    return mapped;
  }

  function reduce(uint256[] memory A, function(uint256, uint256) pure returns (uint256) fn)
    internal
    pure
    returns (uint256)
  {
    uint256 reduced = A[0];
    for (uint256 i = 1; i < A.length; i++) {
      reduced = fn(reduced, A[i]);
    }
    return reduced;
  }

  /**
   * Looks through each value in the list, returning an array of all the values that pass a truth test (predicate).
   */
  function filter(uint256[] memory A, function(uint256) pure returns (bool) predicate)
    internal
    pure
    returns (uint256[] memory)
  {
    bool[] memory includeMap = new bool[](A.length);
    uint256 count = 0;
    for (uint256 i = 0; i < A.length; i++) {
      if (predicate(A[i])) {
        includeMap[i] = true;
        count++;
      }
    }
    uint256[] memory filtered = new uint256[](count);
    uint256 j = 0;
    for (i = 0; i < A.length; i++) {
      if (includeMap[i]) {
        filtered[j] = A[i];
        j++;
      }
    }
    return filtered;
  }

  function argFilter(uint256[] memory A, function(uint256) pure returns (bool) predicate)
    internal
    pure
    returns (uint256[] memory)
  {
    bool[] memory includeMap = new bool[](A.length);
    uint256 count = 0;
    for (uint256 i = 0; i < A.length; i++) {
      if (predicate(A[i])) {
        includeMap[i] = true;
        count++;
      }
    }
    uint256[] memory indexArray = new uint256[](count);
    uint256 j = 0;
    for (i = 0; i < A.length; i++) {
      if (includeMap[i]) {
        indexArray[j] = i;
        j++;
      }
    }
    return indexArray;
  }

  // https://docs.scipy.org/doc/numpy-1.14.0/user/basics.indexing.html#index-arrays
  function argGet(uint256[] memory A, uint256[] memory indexArray)
    internal
    pure
    returns (uint256[] memory)
  {
    uint256[] memory array = new uint256[](indexArray.length);
    for (uint256 i = 0; i < indexArray.length; i++) {
      array[i] = A[indexArray[i]];
    }
    return array;
  }

  /**
   * @return Returns index and isIn for the first occurrence starting from index 0
   */
  function indexOf(uint256[] memory A, uint256 a) internal returns (uint256, bool) {
    uint256 length = A.length;
    for (uint256 i = 0; i < length; i++) {
      if (A[i] == a) {
        return (i, true);
      }
    }
    return (0, false);
  }

  function sPop(uint256[] storage A, uint256 index) internal returns (uint256) {
    uint256 length = A.length;
    if (index >= length) {
      revert("Error: index out of bounds");
    }
    uint256 entry = A[index];
    for (uint256 i = index; i < length - 1; i++) {
      A[i] = A[i + 1];
    }
    A.length--;
    return entry;
  }

  function sPopCheap(uint256[] storage A, uint256 index) internal returns (uint256) {
    uint256 length = A.length;
    if (index >= length) {
      revert("Error: index out of bounds");
    }
    uint256 entry = A[index];
    if (index != length - 1) {
      A[index] = A[length - 1];
      delete A[length - 1];
    }
    A.length--;
    return entry;
  }

  function isEqual(uint256[] A, uint256[] B) internal pure returns (bool) {
    if (A.length != B.length) {
      return false;
    }
    for (uint256 i = 0; i < A.length; i++) {
      if (A[i] != B[i]) {
        return false;
      }
    }
    return true;
  }

  function equal(uint256[] A, uint256[] B) internal pure returns (bool) {
    return isEqual(A, B);
  }

  function eq(uint256[] A, uint256[] B) internal pure returns (bool) {
    return isEqual(A, B);
  }

}
