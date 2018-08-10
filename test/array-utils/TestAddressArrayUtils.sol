pragma solidity 0.4.24;


import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";

import "../../contracts/array-utils/AddressArrayUtils.sol";


contract TestAddressArrayUtils {
  using AddressArrayUtils for address[];

  address[] addressesA;
  address[] addressesB;
  address[] addressesC;

  function beforeEach() public {
    addressesA.length = 0;
    addressesB.length = 0;
    addressesC.length = 0;

    addressesA.push(address(0x1));
    addressesA.push(address(0x2));
    addressesA.push(address(0x3));
    addressesA.push(address(0x4));

    addressesB.push(address(0x8));
    addressesB.push(address(0x9));
    addressesB.push(address(0x10));
  }

  function testIsEqualTrue() public {
    addressesC.push(address(0x1));
    addressesC.push(address(0x2));
    addressesC.push(address(0x3));
    addressesC.push(address(0x4));
    bool equal = addressesA.isEqual(addressesC);
    Assert.equal(equal, true, "should return equal");
  }

  function testIsEqualFalse() public {
    bool equal = addressesA.isEqual(addressesB);
    Assert.equal(equal, false, "should not return not equal");
  }

  function testIndexFindsItem() public {
    (uint256 index, bool isIn) = addressesA.indexOf(address(0x2));
    Assert.isTrue(isIn, "should be ok");
    Assert.equal(index, 1, "should return index 1");
  }

  function testIndexDoesNotFindItem() public {
    (uint256 index, bool isIn) = addressesA.indexOf(address(0x0));
    Assert.isFalse(isIn, "should not be ok");
    Assert.equal(index, 0, "should return index 0");
  }

  function testContainsFindsItem() public {
    bool isIn = addressesA.contains(0x3);
    Assert.isTrue(isIn, "should be true");
  }

  function testContainsDoesNotFindItem() public {
    bool isIn = addressesA.contains(0x12);
    Assert.isFalse(isIn, "should be false");
  }

  function testExtend() public {
    address[] memory newAddresses = addressesA.extend(addressesB);
    Assert.equal(newAddresses.length, 7, "extended length should be 7");
    Assert.equal(newAddresses[0], address(0x1), "element 0 should match");
    Assert.equal(newAddresses[1], address(0x2), "element 1 should match");
    Assert.equal(newAddresses[2], address(0x3), "element 2 should match");
    Assert.equal(newAddresses[3], address(0x4), "element 3 should match");
    Assert.equal(newAddresses[4], address(0x8), "element 4 should match");
    Assert.equal(newAddresses[5], address(0x9), "element 5 should match");
    Assert.equal(newAddresses[6], address(0x10), "element 6 should match");
  }

  function testSExtend() public {
    addressesA.sExtend(addressesB);
    Assert.equal(addressesA.length, 7, "extended length should be 7");
    Assert.equal(addressesA[0], address(0x1), "element 0 should match");
    Assert.equal(addressesA[1], address(0x2), "element 1 should match");
    Assert.equal(addressesA[2], address(0x3), "element 2 should match");
    Assert.equal(addressesA[3], address(0x4), "element 3 should match");
    Assert.equal(addressesA[4], address(0x8), "element 4 should match");
    Assert.equal(addressesA[5], address(0x9), "element 5 should match");
    Assert.equal(addressesA[6], address(0x10), "element 6 should match");
  }

  function testSExtendEmpty() public {
    addressesA.sExtend(addressesC);
    Assert.equal(addressesA.length, 4, "extended length should be 4");
  }

  function testSReverseEven() public {
    addressesA.sReverse();
    Assert.equal(addressesA.length, 4, "reversed length should be 4");
    Assert.equal(addressesA[0], address(0x4), "element 0 should match");
    Assert.equal(addressesA[1], address(0x3), "element 1 should match");
    Assert.equal(addressesA[2], address(0x2), "element 2 should match");
    Assert.equal(addressesA[3], address(0x1), "element 3 should match");
  }

  function testSReverseOdd() public {
    addressesB.sReverse();
    Assert.equal(addressesB.length, 3, "reversed length should be 3");
    Assert.equal(addressesB[0], address(0x10), "element 0 should match");
    Assert.equal(addressesB[1], address(0x9), "element 1 should match");
    Assert.equal(addressesB[2], address(0x8), "element 2 should match");
  }

  function testSPopCheap() public {
    address entry = addressesA.sPopCheap(2);
    Assert.equal(addressesA.length, 3, "removed length should be 3");
    Assert.equal(entry, address(0x3), "popped entry should be correct");
    Assert.equal(addressesA[0], address(0x1), "element 0 should match");
    Assert.equal(addressesA[1], address(0x2), "element 1 should match");
    Assert.equal(addressesA[2], address(0x4), "element 2 should match");
  }

  function testPop() public {
    (address[] memory newAddresses, address entry) = addressesA.pop(0);
    Assert.equal(newAddresses.length, 3, "length should be 3");
    Assert.equal(entry, address(0x1), "popped entry should be correct");
    Assert.equal(newAddresses[0], address(0x2), "element 0 should match");
    Assert.equal(newAddresses[1], address(0x3), "element 1 should match");
    Assert.equal(newAddresses[2], address(0x4), "element 2 should match");
  }

  function testSRemoveCheap() public {
    addressesA.sRemoveCheap(0x1);
    Assert.equal(addressesA.length, 3, "removed length should be 3");
    Assert.equal(addressesA[0], address(0x4), "element 0 should match");
    Assert.equal(addressesA[1], address(0x2), "element 1 should match");
    Assert.equal(addressesA[2], address(0x3), "element 2 should match");
  }

}
