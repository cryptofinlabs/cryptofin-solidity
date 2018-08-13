# CryptoFin Solidity
A collection of Solidity libraries, with an initial focus on arrays.

## [Documentation](https://cryptofinlabs.github.io/cryptofin-solidity/)
Documentation is generated from Natspec.

## Quickstart

    npm install --save cryptofin-solidity

### Use it in a project

    import "cryptofin-solidity/contracts/array-utils/AddressArrayUtils.sol";

    contract Contract {
      using AddressArrayUtils for address[];

      function containsDeadBeef(address[] memory addresses)
        returns (bool)
      {
        return addresses.contains(address(0xdeadbeef));
      }

    }

## Contributing
If you'd like to contribute, this library is in need of:

- More functionality
- More tests
- [Other open feature requests](https://github.com/cryptofinlabs/cryptofin-solidity/labels/enhancement)

## v0.0.x
This library is still relatively new and may have breaking changes in the future.
