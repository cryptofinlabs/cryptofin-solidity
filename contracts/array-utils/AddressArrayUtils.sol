pragma solidity 0.4.24;


library AddressArrayUtils {

  /**
   * @return Returns index and isIn for the first occurrence starting from index 0
   */ 
  function indexOf(address[] A, address a) internal pure returns (uint256, bool) {
    uint256 length = A.length;
    for (uint256 i = 0; i < length; i++) {
      if (A[i] == a) {
        return (i, true);
      }
    }
    return (0, false);
  }

  /**
  * @return Returns isIn for the first occurrence starting from index 0
  */ 
  function contains(address[] A, address a) internal pure returns (bool) {
    (, bool isIn) = indexOf(A, a);
    return isIn;
  }


  /// @return Returns index and isIn for the first occurrence starting from
  /// end
  function indexOfFromEnd(address[] A, address a) internal pure returns (uint256, bool) {
    uint256 length = A.length;
    for (uint256 i = length; i > 0; i--) {
      if (A[i - 1] == a) {
        return (i, true);
      }
    }
    return (0, false);
  }

  function extend(address[] storage A, address[] storage B) internal {
    uint256 length = B.length;
    for (uint256 i = 0; i < length; i++) {
      A.push(B[i]);
    }
  }

  /**
  * @dev Reverses address array in place
  */
  function reverse(address[] storage A) internal {
    address t;
    uint256 length = A.length;
    for (uint256 i = 0; i < length / 2; i++) {
      t = A[i];
      A[i] = A[A.length - i - 1];
      A[A.length - i - 1] = t;
    }
  }

  /**
  * Deletes address at index and fills the spot with the last address
  * @return Returns the new array length
  */
  function removeIndex(address[] storage A, uint256 index) internal returns (uint256) {
    if (index >= A.length) {
      return A.length;
    }
    A[index] = A[A.length - 1];
    delete A[A.length - 1];
    A.length--;
    return A.length;
  }

  /**
   * Deletes address at index and fills the spot with the last address
   * @return Returns the new array length
   */
  function remove(address[] storage A, address a) internal returns (uint256) {
    (uint256 index, bool isIn) = indexOf(A, a);
    if (!isIn) {
      return A.length;
    } else {
      return removeIndex(A, index);
    }
  }

  /**
   * Returns whether or not there's a duplicate
   * Runs in O(n^2)
   */
  function hasDuplicate(address[] A) internal pure returns (bool) {
    uint256 length = A.length;
    for (uint256 i = 0; i < length - 1; i++) {
      for (uint256 j = i + 1; j < length; j++) {
        if (A[i] == A[j]) {
          return true;
        }
      }
    }
    return false;
  }

  function isEqual(address[] A, address[] B) internal pure returns (bool) {
    uint256 length = A.length;
    for (uint256 i = 0; i < length; i++) {
      if (A[i] != B[i]) {
        return false;
      }
    }
    return true;
  }

}
