pragma solidity 0.4.24;


library AddressArrayUtils {

  /**
   * @return Returns index and isIn for the first occurrence starting from index 0
   */ 
  function indexOf(address[] memory A, address a) internal pure returns (uint256, bool) {
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
  function contains(address[] memory A, address a) internal pure returns (bool) {
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

  function extend(address[] memory A, address[] memory B) internal pure returns (address[] memory) {
    uint256 aLength = A.length;
    uint256 bLength = B.length;
    address[] memory newAddresses = new address[](aLength + bLength);
    for (uint256 i = 0; i < aLength; i++) {
      newAddresses[i] = A[i];
    }
    for (i = 0; i < bLength; i++) {
      newAddresses[aLength + i] = B[i];
    }
    return newAddresses;
  }

  function sExtend(address[] storage A, address[] storage B) internal {
    uint256 length = B.length;
    for (uint256 i = 0; i < length; i++) {
      A.push(B[i]);
    }
  }

  function intersect(address[] memory A, address[] memory B) internal pure returns (address[] memory) {
    uint256 length = A.length;
    bool[] memory includeMap = new bool[](length);
    uint256 newLength = 0;
    for (uint256 i = 0; i < length; i++) {
      if (contains(B, A[i])) {
        includeMap[i] = true;
        newLength++;
      }
    }
    address[] memory newAddresses = new address[](newLength);
    uint256 j = 0;
    for (i = 0; i < length; i++) {
      if (includeMap[i]) {
        newAddresses[j] = A[i];
        j++;
      }
    }
    return newAddresses;
  }

  /**
   * Ordering is nor guaranteed
   * Computes union with A + B - A^B
   */
  function union(address[] memory A, address[] memory B) internal pure returns (address[] memory) {
    address[] memory leftDifference = difference(A, B);
    address[] memory rightDifference = difference(B, A);
    address[] memory intersection = intersect(A, B);
    return extend(leftDifference, extend(intersection, rightDifference));
  }

  /**
   * Computes the difference of two arrays
   * Removes duplicates
   */
  function difference(address[] memory A, address[] memory B) internal pure returns (address[] memory) {
    uint256 length = A.length;
    bool[] memory includeMap = new bool[](length);
    uint256 newLength = 0;
    // First count the new length because can't push for in-memory arrays
    for (uint256 i = 0; i < length; i++) {
      address e = A[i];
      if (!contains(B, e)) {
        includeMap[i] = true;
        newLength++;
      }
    }
    address[] memory newAddresses = new address[](newLength);
    uint256 j = 0;
    for (i = 0; i < length; i++) {
      if (includeMap[i]) {
        newAddresses[j] = A[i];
        j++;
      }
    }
    return newAddresses;
  }

  // TODO: rename reverseStorage or split up into separate AddressStorageArrayUtils
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
  * Removes specified index from array
  * Resulting ordering is not guaranteed
  * @return Returns the new array and its length
  */
  function removeIndex(address[] memory A, uint256 index) internal pure returns (address[] memory, uint256) {
    uint256 length = A.length;
    address[] memory newAddresses = new address[](length - 1);
    for (uint256 i = 0; i < index; i++) {
      newAddresses[i] = A[i];
    }
    for (i = index + 1; i < length; i++) {
      newAddresses[i - 1] = A[i];
    }
    return (newAddresses, length - 1);
  }

  function remove(address[] memory A, address a) internal pure returns (address[] memory, uint256) {
    (uint256 index, bool isIn) = indexOf(A, a);
    if (!isIn) {
      return (A, A.length);
    } else {
      return removeIndex(A, index);
    }
  }


  /**
  * Deletes address at index and fills the spot with the last address
  * Resulting ordering is not guaranteed
  * @return Returns the new array length
  */
  function sRemoveIndex(address[] storage A, uint256 index) internal returns (uint256) {
    uint256 length = A.length;
    if (index >= length) {
      return length;
    }
    // TODO: check if this saves gas
    // if (index != length - 1) {
    A[index] = A[length - 1];
    delete A[length - 1];
    // }
    A.length--;
    return A.length;
  }

  /**
   * Deletes address at index and fills the spot with the last address
   * @return Returns the new array length
   */
  function sRemove(address[] storage A, address a) internal returns (uint256) {
    (uint256 index, bool isIn) = indexOf(A, a);
    if (!isIn) {
      return A.length;
    } else {
      return sRemoveIndex(A, index);
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
