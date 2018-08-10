const AddressArrayUtilsContract = artifacts.require('AddressArrayUtilsContract');
const assertRevert = require('../helpers/assertRevert.js');

contract('AddressArrayUtils', function(accounts) {

  context('main', async () => {
    let addressArrayUtilsContract;

    beforeEach(async () => {
      addressArrayUtilsContract = await AddressArrayUtilsContract.new();
    });

    it('should find index of entry correctly', async () => {
      const A = [0x2, 0x1, 0x3];
      const [index, entry] = await addressArrayUtilsContract.indexOf.call(A, 0x2);
      assert.equal(index.toNumber(), 0);
    });

    it('should sPopCheap correctly', async () => {
      const A = [0x2, 0x1, 0x3];
      await addressArrayUtilsContract.setAddressesA(A);
      const entry = await addressArrayUtilsContract.sPopCheap.call(1);
      assert.equal(entry, 0x1)

      await addressArrayUtilsContract.sPopCheap(0);
      const addressesA = await addressArrayUtilsContract.getAddressesA.call();

      assert.equal(addressesA.length, 2);
      assert.equal(addressesA[0], 0x3);
      assert.equal(addressesA[1], 0x1);
    });

    it('sPopCheap should fail when array is empty', async () => {
      const A = [];
      await addressArrayUtilsContract.setAddressesA(A);
      try {
        await addressArrayUtilsContract.sPopCheap.call(0);
        assert.fail('should have reverted');
      } catch(e) {
        assertRevert(e);
      }
    });

    it('sPopCheap should fail when index out of bounds', async () => {
      const A = [0x2, 0x1, 0x3];
      await addressArrayUtilsContract.setAddressesA(A);
      try {
        await addressArrayUtilsContract.sPopCheap.call(4);
        assert.fail('should have reverted');
      } catch(e) {
        assertRevert(e);
      }
    });

    it('sRemoveCheap should fail when entry does not exist', async () => {
      const A = [0x2, 0x1, 0x3];
      await addressArrayUtilsContract.setAddressesA(A);
      try {
        await addressArrayUtilsContract.sRemoveCheap.call(0x1111);
        assert.fail('should have reverted');
      } catch(e) {
        assertRevert(e);
      }
    });


  });

  context('measure gas costs', async () => {
    let addressArrayUtilsContract;

    beforeEach(async () => {
      addressArrayUtilsContract = await AddressArrayUtilsContract.new();
    });

    it('indexOf', async () => {
      const A = [0x2, 0x1, 0x3];
      await addressArrayUtilsContract.indexOf(A, 0x2);
    });

    it('sPop', async () => {
      const A = [0x2, 0x1, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8];
      await addressArrayUtilsContract.setAddressesA(A);
      await addressArrayUtilsContract.sPop(6);
      await addressArrayUtilsContract.sPop(0);
      await addressArrayUtilsContract.sPop(1);

      const B = [0x2, 0x1, 0x3, 0x4, 0x5, 0x6, 0x7, 0x0, 0x2, 0x1, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x2, 0x1, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8];
      await addressArrayUtilsContract.setAddressesA(B);
      await addressArrayUtilsContract.sPop(16);
      await addressArrayUtilsContract.sPop(0);
      await addressArrayUtilsContract.sPop(1);
    });

    it('sPopCheap', async () => {
      const A = [0x2, 0x1, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8];
      await addressArrayUtilsContract.setAddressesA(A);
      await addressArrayUtilsContract.sPopCheap(6);
      await addressArrayUtilsContract.sPopCheap(0);
      await addressArrayUtilsContract.sPopCheap(1);

      const B = [0x2, 0x1, 0x3, 0x4, 0x5, 0x6, 0x7, 0x0, 0x2, 0x1, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x2, 0x1, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8];
      await addressArrayUtilsContract.setAddressesA(B);
      await addressArrayUtilsContract.sPopCheap(16);
      await addressArrayUtilsContract.sPopCheap(0);
      await addressArrayUtilsContract.sPopCheap(1);
    });

    it('contains', async () => {
      const A = [0x2, 0x1, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8];
      await addressArrayUtilsContract.contains(A, 0x3);
      await addressArrayUtilsContract.contains(A, 0x8);
    });

    //it('indexOfFromEnd', async () => {
    //});

    it('extend', async () => {
      const A = [0x2, 0x1, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8];
      const B = [0x4, 0x111, 0x113];
      await addressArrayUtilsContract.extend(A, B);
    });

    //it('sExtend', async () => {
    //});

    //it('intersect', async () => {
    //});

    //it('union', async () => {
    //});

    //it('unionB', async () => {
    //});

    //it('difference', async () => {
    //});

    //it('sReverse', async () => {
    //});

    //it('pop', async () => {
    //});

    //it('remove', async () => {
    //});

    //it('sPopCheap', async () => {
    //});

    //it('sRemoveCheap', async () => {
    //});

    //it('hasDuplicate', async () => {
    //});

    //it('isEqual', async () => {
    //});

    //it('argGet', async () => {
    //});

    //it('isEqual', async () => {
    //});

    //it('hasDuplicate', async () => {
    //});

    //it('sRemoveCheap', async () => {
    //});

    //it('remove', async () => {
    //});

    //it('pop', async () => {
    //});

    //it('sReverse', async () => {
    //});

    //it('difference', async () => {
    //});

    //it('unionB', async () => {
    //});

    //it('union', async () => {
    //});

    //it('intersect', async () => {
    //});

    //it('sExtend', async () => {
    //});

  });

});
