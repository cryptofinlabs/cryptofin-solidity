pragma solidity 0.4.24;


import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";

import "../../contracts/array-utils/AddressArrayUtils.sol";


// Split up because of out of gas errors
contract TestAddressArrayUtils2 {
  using AddressArrayUtils for address[];

  address[] addressesA;
  address[] addressesB;
  address[] addressesC;
  address[] addressesD;

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

  // TODO: test difference with duplicates
  function testDifference() public {
    addressesC.push(address(0x2));
    addressesC.push(address(0x4));
    address[] memory newAddresses = addressesA.difference(addressesC);

    Assert.equal(addressesA.length, 4, "length should be unchanged");
    Assert.equal(addressesA[0], address(0x1), "element 0 should match");
    Assert.equal(addressesA[1], address(0x2), "element 1 should match");
    Assert.equal(addressesA[2], address(0x3), "element 2 should match");
    Assert.equal(addressesA[3], address(0x4), "element 3 should match");

    Assert.equal(newAddresses.length, 2, "length should be 2");
    Assert.equal(newAddresses[0], address(0x1), "element 0 should match");
    Assert.equal(newAddresses[1], address(0x3), "element 1 should match");
  }

  function testIntersect() public {
    addressesC.push(address(0x1));
    addressesC.push(address(0x2));
    address[] memory newAddresses = addressesA.intersect(addressesC);
    Assert.equal(newAddresses.length, 2, "length should be 2");
    Assert.equal(newAddresses[0], address(0x1), "element 0 should match");
    Assert.equal(newAddresses[1], address(0x2), "element 1 should match");
  }

  function testIntersect2() public {
    addressesC.push(address(0x1));
    addressesC.push(address(0x2));
    addressesC.push(address(0x3));
    addressesC.push(address(0x10));
    addressesC.push(address(0x11));
    address[] memory newAddresses = addressesA.intersect(addressesC);
    Assert.equal(newAddresses.length, 3, "length should be 3");
    Assert.equal(newAddresses[0], address(0x1), "element 0 should match");
    Assert.equal(newAddresses[1], address(0x2), "element 1 should match");
    Assert.equal(newAddresses[2], address(0x3), "element 2 should match");
  }

  function testUnion() public {
    addressesC.push(address(0x1));
    addressesC.push(address(0x2));
    addressesC.push(address(0x3));
    addressesC.push(address(0x10));
    addressesC.push(address(0x11));
    address[] memory newAddresses = addressesA.union(addressesC);
    Assert.equal(newAddresses.length, 6, "length should be 6");
    Assert.equal(newAddresses[0], address(0x4), "element 0 should match");
    Assert.equal(newAddresses[1], address(0x1), "element 1 should match");
    Assert.equal(newAddresses[2], address(0x2), "element 2 should match");
    Assert.equal(newAddresses[3], address(0x3), "element 3 should match");
    Assert.equal(newAddresses[4], address(0x10), "element 4 should match");
    Assert.equal(newAddresses[5], address(0x11), "element 5 should match");
  }

  function testUnionLeftEmpty() public {
    address[] memory newAddresses = addressesC.union(addressesA);
    Assert.equal(newAddresses.length, 4, "length should be 4");
    Assert.equal(newAddresses[0], address(0x1), "element 0 should match");
    Assert.equal(newAddresses[1], address(0x2), "element 1 should match");
    Assert.equal(newAddresses[2], address(0x3), "element 2 should match");
    Assert.equal(newAddresses[3], address(0x4), "element 3 should match");
  }

  function testUnionRightEmpty() public {
    address[] memory newAddresses = addressesA.union(addressesC);
    Assert.equal(newAddresses.length, 4, "length should be 4");
    Assert.equal(newAddresses[0], address(0x1), "element 0 should match");
    Assert.equal(newAddresses[1], address(0x2), "element 1 should match");
    Assert.equal(newAddresses[2], address(0x3), "element 2 should match");
    Assert.equal(newAddresses[3], address(0x4), "element 3 should match");
  }

  function testUnionBothEmpty() public {
    address[] memory newAddresses = addressesD.union(addressesC);
    Assert.equal(newAddresses.length, 0, "length should be 0");
  }

}
