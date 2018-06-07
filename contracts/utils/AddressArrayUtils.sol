pragma solidity 0.4.24;


library AddressArrayUtils {

    /**
     * @return Returns index and isIn for the first occurrence starting from index 0
     */ 
    function index(address[] addresses, address a) internal pure returns (uint256, bool) {
        for (uint256 i = 0; i < addresses.length; i++) {
            if (addresses[i] == a) {
                return (i, true);
            }
        }
        return (0, false);
    }

    /// @return Returns index and isIn for the first occurrence starting from
    /// end
    function indexOfFromEnd(address[] addresses, address a) internal pure returns (uint256, bool) {
      for (uint256 i = addresses.length; i > 0; i--) {
        if (addresses[i - 1] == a) {
          return (i, true);
        }
      }
      return (0, false);
    }

    function extend(address[] storage a, address[] storage b) internal returns (bool) {
        for (uint256 i = 0; i < b.length; i++) {
            a.push(b[i]);
        }
        return true;
    }

    /**
     * @dev Reverses address array in place
     */
    function reverse(address[] storage a) internal returns (bool) {
        address t;
        for (uint256 i = 0; i < a.length / 2; i++) {
            t = a[i];
            a[i] = a[a.length - i - 1];
            a[a.length - i - 1] = t;
        }
        return true;
    }

    /**
     * Deletes address at index and fills the spot with the last address
     * @return Returns the new array length
     */
    function remove(address[] storage addresses, uint256 index) internal returns (uint256) {
      if (index >= addresses.length) {
        return addresses.length;
      }
      addresses[index] = addresses[addresses.length - 1];
      delete addresses[addresses.length - 1];
      addresses.length--;
      return addresses.length;
    }

    /**
     * Returns whether or not there's a duplicate
     * Runs in O(n^2)
     */
    function hasDuplicate(address[] addresses) internal pure returns (bool) {
      for (uint256 i = 0; i < addresses.length - 1; i++) {
        for (uint256 j = i + 1; j < addresses.length; j++) {
          if (addresses[i] == addresses[j]) {
            return true;
          }
        }
      }
      return false;
    }

}
