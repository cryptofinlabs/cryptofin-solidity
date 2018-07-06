pragma solidity 0.4.24;


import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";

import "../../contracts/array-utils/AddressArrayUtils.sol";


contract TestAddressArrayUtils {
    using AddressArrayUtils for address[];

    address[] _a;
    address[] _b;
    address[] _c;

    function beforeEach() public {
        _a.length = 0;
        _b.length = 0;
        _c.length = 0;

        _a.push(address(0x1));
        _a.push(address(0x2));
        _a.push(address(0x3));
        _a.push(address(0x4));

        _b.push(address(0x8));
        _b.push(address(0x9));
        _b.push(address(0x10));
    }

    function testIndexFindsItem() public {
        uint result;
        bool ok;
        (result, ok) = _a.index(address(0x2));
        Assert.isTrue(ok, "should be ok");
        Assert.equal(result, 1, "should return index 1");
    }

    function testIndexDoesNotFindItem() public {
        uint result;
        bool ok;
        (result, ok) = _a.index(address(0x0));
        Assert.isFalse(ok, "should not be ok");
        Assert.equal(result, 0, "should return index 0");
    }

    function testExtendExtends() public {
        bool ok = _a.extend(_b);
        Assert.isTrue(ok, "should be ok");
        Assert.equal(_a.length, 7, "extended length should be 7");
    }

    function testExtendExtendsEmpty() public {
        bool ok = _a.extend(_c);
        Assert.isTrue(ok, "should be ok");
        Assert.equal(_a.length, 4, "extended length should be 4");
    }

    function testReverseEven() public {
        bool ok = _a.reverse();
        Assert.isTrue(ok, "should be ok");
        Assert.equal(_a.length, 4, "reversed length should be 4");
        Assert.equal(_a[0], address(0x4), "element 0 should match");
        Assert.equal(_a[1], address(0x3), "element 1 should match");
        Assert.equal(_a[2], address(0x2), "element 2 should match");
        Assert.equal(_a[3], address(0x1), "element 3 should match");
    }

    function testReverseOdd() public {
        bool ok = _b.reverse();
        Assert.isTrue(ok, "should be ok");
        Assert.equal(_b.length, 3, "reversed length should be 3");
        Assert.equal(_b[0], address(0x10), "element 0 should match");
        Assert.equal(_b[1], address(0x9), "element 1 should match");
        Assert.equal(_b[2], address(0x8), "element 2 should match");
    }

}
