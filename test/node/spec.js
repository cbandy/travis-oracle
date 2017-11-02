'use strict';

var expect = require('chai').expect;
var oracledb = require('oracledb');

describe('library access', function () {
  it('can access without password as the current user', function () {
    oracledb.getConnection({connectString: '/'}, function (err, connection) {
      expect(err).to.not.exist;

      connection.execute('SELECT 1 FROM DUAL', function (err, result) {
        expect(err).to.not.exist;
        expect(result.rows).to.equal([[1]]);
      });
    });
  });
});
