pragma solidity 0.4.24;


import "truffle/Assert.sol";
import "../../contracts/rationals/Rational.sol";
import "../../contracts/rationals/RationalMath.sol";


contract TestRationalMath {

    Rational.Rational256 public globalRate = Rational.Rational256(2, 3);

    function testMul() public {
        Rational.Rational256 memory a = Rational.Rational256(1, 5);
        Rational.Rational256 memory b = Rational.Rational256(3, 7);
        Rational.Rational256 memory result = RationalMath.mul(a, b);
        Rational.Rational256 memory expected = Rational.Rational256(3, 35);
        Assert.equal(result.n, expected.n, "result is equal to expected");
        Assert.equal(result.d, expected.d, "result is equal to expected");
    }

    // TODO: overflow cases for mul

    function testScalarMul() public {
        uint256 amount = 1000;
        Rational.Rational256 memory rate = Rational.Rational256(1, 5);  // 0.2
        uint256 result = RationalMath.scalarMul(rate, amount);
        Assert.equal(result, 200, "result is equal to expected");
    }

    function testScalarMul2() public {
        uint256 amount = 10**16;
        Rational.Rational256 memory rate = Rational.Rational256(418, 5);  // 83.6
        uint256 result = RationalMath.scalarMul(rate, amount);
        Assert.equal(result, 836*10**15, "result is equal to expected");
    }

    // Test with storage Rational
    function testScalarMul3() public {
        uint256 amount = 100;
        uint256 result = RationalMath.scalarMul(globalRate, amount);
        Assert.equal(result, 66, "result is equal to expected");
    }

}
