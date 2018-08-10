// TODO: Ideally this file is  auto-generated
pragma solidity 0.4.24;


import "./AddressArrayUtils.sol";


// `pure` was removed from all functions so eth-gas-reporter measures them
contract AddressArrayUtilsContract {

  address[] public addressesA;

  function getAddressesA() public view returns (address[]) {
    return addressesA;
  }

  function setAddressesA(address[] memory A) public {
    addressesA = A;
  }

  function indexOf(address[] memory A, address a) public returns (uint256, bool) {
    return AddressArrayUtils.indexOf(A, a);
  }

  function contains(address[] memory A, address a) public returns (bool) {
    return AddressArrayUtils.contains(A, a);
  }

  function indexOfFromEnd(address[] A, address a) public returns (uint256, bool) {
    return AddressArrayUtils.indexOfFromEnd(A, a);
  }

  function extend(address[] memory A, address[] memory B) public returns (address[] memory) {
    return AddressArrayUtils.extend(A, B);
  }

  //function sExtend(address[] storage A, address[] storage B) public {
    //return AddressArrayUtils.sExtend(A, B);
  //}

  function intersect(address[] memory A, address[] memory B) public returns (address[] memory) {
    return AddressArrayUtils.intersect(A, B);
  }

  function union(address[] memory A, address[] memory B) public returns (address[] memory) {
    return AddressArrayUtils.union(A, B);
  }

  function unionB(address[] memory A, address[] memory B) public returns (address[] memory) {
    return AddressArrayUtils.unionB(A, B);
  }

  function difference(address[] memory A, address[] memory B) public returns (address[] memory) {
    return AddressArrayUtils.difference(A, B);
  }

  //function sReverse(address[] storage A) public {
    //return AddressArrayUtils.sReverse(A);
  //}

  function pop(address[] memory A, uint256 index)
    public
    returns (address[] memory, address)
  {
    return AddressArrayUtils.pop(A, index);
  }

  function remove(address[] memory A, address a)
    public
    returns (address[] memory)
  {
    return AddressArrayUtils.remove(A, a);
  }

  function sPopCheap(uint256 index) public returns (address) {
    return AddressArrayUtils.sPopCheap(addressesA, index);
  }

  function sRemoveCheap(address a) public {
    return AddressArrayUtils.sRemoveCheap(addressesA, a);
  }

  function hasDuplicate(address[] A) public returns (bool) {
    return AddressArrayUtils.hasDuplicate(A);
  }

  function isEqual(address[] A, address[] B) public returns (bool) {
    return AddressArrayUtils.isEqual(A, B);
  }

  function argGet(address[] memory A, uint256[] memory indexArray)
    returns (address[] memory)
  {
    return AddressArrayUtils.argGet(A, indexArray);
  }

}
