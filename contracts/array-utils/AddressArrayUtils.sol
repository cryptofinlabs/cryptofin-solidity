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
  // named includes in lots of languages
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
   * Ordering is not guaranteed
   * Computes union with A + B - A^B
   */
  function union(address[] memory A, address[] memory B) internal pure returns (address[] memory) {
    address[] memory leftDifference = difference(A, B);
    address[] memory rightDifference = difference(B, A);
    address[] memory intersection = intersect(A, B);
    return extend(leftDifference, extend(intersection, rightDifference));
  }

  /**
   * Alternate implementation
   * Assumes there are no duplicates
   */
  function unionB(address[] memory A, address[] memory B) internal pure returns (address[] memory) {
    bool[] memory includeMap = new bool[](A.length + B.length);
    uint256 i = 0;
    uint256 count = 0;
    for (i = 0; i < A.length; i++) {
      includeMap[i] = true;
      count++;
    }
    for (i = 0; i < B.length; i++) {
      if (!contains(A, B[i])) {
        includeMap[A.length + i] = true;
        count++;
      }
    }
    address[] memory newAddresses = new address[](count);
    uint256 j = 0;
    for (i = 0; i < A.length; i++) {
      if (includeMap[i]) {
        newAddresses[j] = A[i];
        j++;
      }
    }
    for (i = 0; i < B.length; i++) {
      if (includeMap[A.length + i]) {
        newAddresses[j] = B[i];
        j++;
      }
    }
    return newAddresses;
  }

  /**
   * Computes the difference of two arrays
   * Assumes there are no duplicates
   */
  function difference(address[] memory A, address[] memory B) internal pure returns (address[] memory) {
    uint256 length = A.length;
    bool[] memory includeMap = new bool[](length);
    uint256 count = 0;
    // First count the new length because can't push for in-memory arrays
    for (uint256 i = 0; i < length; i++) {
      address e = A[i];
      if (!contains(B, e)) {
        includeMap[i] = true;
        count++;
      }
    }
    address[] memory newAddresses = new address[](count);
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
  * @dev Reverses address array in place
  */
  function sReverse(address[] storage A) internal {
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
  * @return Returns the new array and the removed entry
  */
  function pop(address[] memory A, uint256 index)
    internal
    pure
    returns (address[] memory, address)
  {
    uint256 length = A.length;
    address[] memory newAddresses = new address[](length - 1);
    for (uint256 i = 0; i < index; i++) {
      newAddresses[i] = A[i];
    }
    for (i = index + 1; i < length; i++) {
      newAddresses[i - 1] = A[i];
    }
    return (newAddresses, A[index]);
  }

  /**
   * @return Returns the new array
   */
  function remove(address[] memory A, address a)
    internal
    pure
    returns (address[] memory)
  {
    (uint256 index, bool isIn) = indexOf(A, a);
    if (!isIn) {
      revert();
    } else {
      (address[] memory _A,) = pop(A, index);
      return _A;
    }
  }

  function sPop(address[] storage A, uint256 index) internal returns (address) {
    uint256 length = A.length;
    if (index >= length) {
      revert("Error: index out of bounds");
    }
    address entry = A[index];
    for (uint256 i = index; i < length - 1; i++) {
      A[i] = A[i + 1];
    }
    A.length--;
    return entry;
  }

  /**
  * Deletes address at index and fills the spot with the last address
  * Resulting ordering is not guaranteed
  * @return Returns the removed entry
  */
  function sPopCheap(address[] storage A, uint256 index) internal returns (address) {
    uint256 length = A.length;
    if (index >= length) {
      revert("Error: index out of bounds");
    }
    address entry = A[index];
    if (index != length - 1) {
      A[index] = A[length - 1];
      delete A[length - 1];
    }
    A.length--;
    return entry;
  }

  /**
   * Deletes address at index and fills the spot with the last address
   */
  function sRemoveCheap(address[] storage A, address a) internal {
    (uint256 index, bool isIn) = indexOf(A, a);
    if (!isIn) {
      revert("Error: entry not found");
    } else {
      sPopCheap(A, index);
      return;
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

  function argGet(address[] memory A, uint256[] memory indexArray)
    internal
    pure
    returns (address[] memory)
  {
    address[] memory array = new address[](indexArray.length);
    for (uint256 i = 0; i < indexArray.length; i++) {
      array[i] = A[indexArray[i]];
    }
    return array;
  }

}
