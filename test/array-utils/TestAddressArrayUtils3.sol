pragma solidity 0.4.24;


import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";

import "../../contracts/array-utils/AddressArrayUtils.sol";


// Split up because of out of gas errors
contract TestAddressArrayUtils3 {
  using AddressArrayUtils for address[];

  address[] A;
  address[] B;
  address[] C;
  address[] D;

  function beforeEach() public {
    A.length = 0;
    B.length = 0;
    C.length = 0;

    A.push(address(0x1));
    A.push(address(0x2));
    A.push(address(0x3));
    A.push(address(0x4));

    B.push(address(0x8));
    B.push(address(0x9));
    B.push(address(0x10));
  }

  function testUnionB() public {
    C.push(address(0x1));
    C.push(address(0x2));
    C.push(address(0x3));
    C.push(address(0x10));
    C.push(address(0x11));
    address[] memory newAddresses = A.unionB(C);
    Assert.equal(newAddresses.length, 6, "length should be 6");
    Assert.equal(newAddresses[0], address(0x1), "element 0 should match");
    Assert.equal(newAddresses[1], address(0x2), "element 1 should match");
    Assert.equal(newAddresses[2], address(0x3), "element 2 should match");
    Assert.equal(newAddresses[3], address(0x4), "element 3 should match");
    Assert.equal(newAddresses[4], address(0x10), "element 4 should match");
    Assert.equal(newAddresses[5], address(0x11), "element 5 should match");
  }

  function testUnionBLeftEmpty() public {
    address[] memory newAddresses = C.unionB(A);
    Assert.equal(newAddresses.length, 4, "length should be 4");
    Assert.equal(newAddresses[0], address(0x1), "element 0 should match");
    Assert.equal(newAddresses[1], address(0x2), "element 1 should match");
    Assert.equal(newAddresses[2], address(0x3), "element 2 should match");
    Assert.equal(newAddresses[3], address(0x4), "element 3 should match");
  }

  function testUnionBRightEmpty() public {
    address[] memory newAddresses = A.unionB(C);
    Assert.equal(newAddresses.length, 4, "length should be 4");
    Assert.equal(newAddresses[0], address(0x1), "element 0 should match");
    Assert.equal(newAddresses[1], address(0x2), "element 1 should match");
    Assert.equal(newAddresses[2], address(0x3), "element 2 should match");
    Assert.equal(newAddresses[3], address(0x4), "element 3 should match");
  }

  function testUnionBBothEmpty() public {
    address[] memory newAddresses = D.unionB(C);
    Assert.equal(newAddresses.length, 0, "length should be 0");
  }

  function testArgGet() public {
    uint256[] memory indexArray = new uint256[](2);
    indexArray[0] = 1;
    indexArray[1] = 3;

    address[] memory array = A.argGet(indexArray);
    address[] memory expected = new address[](2);
    expected[0] = 0x2;
    expected[1] = 0x4;
    Assert.isTrue(array.isEqual(expected), "array should match expected");
  }

}
