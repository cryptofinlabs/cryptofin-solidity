pragma solidity ^0.4.18;


library UIntArrayUtils {

    function map(uint[] memory a, function(uint) pure returns (uint) f)
        internal
        pure
        returns (uint[] memory)
    {
        uint[] memory r = new uint[](a.length);
        for (uint i = 0; i < a.length; i++) {
            r[i] = f(a[i]);
        }
        return r;
    }

    function reduce(uint[] memory a, function(uint, uint) pure returns (uint) f)
        internal
        pure
        returns (uint)
    {
        uint r = a[0];
        for (uint i = 1; i < a.length; i++) {
            r = f(r, a[i]);
        }
        return r;
    }

}
