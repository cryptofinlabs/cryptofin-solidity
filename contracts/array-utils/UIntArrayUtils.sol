pragma solidity ^0.4.18;


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
   * @return Returns index and isIn for the first occurrence starting from index 0
   */ 
  function indexOf(uint256[] memory A, uint256 a) internal pure returns (uint256, bool) {
    uint256 length = A.length;
    for (uint256 i = 0; i < length; i++) {
      if (A[i] == a) {
        return (i, true);
      }
    }
    return (0, false);
  }

  function sRemoveIndex(uint256[] storage A, uint256 index) internal returns (uint256) {
    uint256 length = A.length;
    if (index >= length) {
      return length;
    }
    A[index] = A[length - 1];
    delete A[length - 1];
    A.length--;
    return A.length;
  }

}
