pragma solidity 0.4.24;


library AddressArrayUtils {

    /**
     * @return Returns index and isIn for the first occurrence starting from index 0
     */ 
    function index(address[] addresses, address a) internal pure returns (uint, bool) {
        for (uint i = 0; i < addresses.length; i++) {
            if (addresses[i] == a) {
                return (i, true);
            }
        }
        return (0, false);
    }

    function extend(address[] storage a, address[] storage b) internal returns (bool) {
        for (uint i = 0; i < b.length; i++) {
            a.push(b[i]);
        }
        return true;
    }

    /**
     * @dev Reverses address array in place
     */
    function reverse(address[] storage a) internal returns (bool) {
        address t;
        for (uint i = 0; i < a.length / 2; i++) {
            t = a[i];
            a[i] = a[a.length - i - 1];
            a[a.length - i - 1] = t;
        }
        return true;
    }

}
