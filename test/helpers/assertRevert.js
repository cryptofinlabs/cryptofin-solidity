// From zeppelin-solidity@v1.5.0:test/helpers/assertRevert.js
module.exports = function (error) {
  assert.isAbove(error.message.search('revert'), -1, 'Error containing "revert" must be returned');
};
