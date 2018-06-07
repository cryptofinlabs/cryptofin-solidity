pragma solidity 0.4.24;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./Rational.sol";


library RationalMath {
    using SafeMath for uint256;

    function mul(Rational.Rational256 memory a, Rational.Rational256 memory b) internal pure returns (Rational.Rational256 memory) {
        return Rational.Rational256({
            n: a.n.mul(b.n),
            d: a.d.mul(b.d)
        });
    }

    function div(Rational.Rational256 memory a, Rational.Rational256 memory b) internal pure returns (Rational.Rational256 memory) {
        assert(b.n != 0);
        return mul(a, reciprocal(b));
    }

    function reciprocal(Rational.Rational256 memory r) internal pure returns (Rational.Rational256 memory) {
        assert(r.n != 0);
        return Rational.Rational256({
            n: r.d,
            d: r.n
        });
    }

    /**
     * @dev Multiplies Rational and uint
     * @return Product as a Rational
     */
    function mul(Rational.Rational256 memory r, uint256 u) internal pure returns (Rational.Rational256 memory) {
        return Rational.Rational256({
            n: r.n.mul(u),
            d: r.d
        });
    }

    /**
     * @dev Multiplies Rational and uint
     * @return Product as a uint
     */
    function scalarMul(Rational.Rational256 memory r, uint256 u) internal pure returns (uint256) {
        return toUInt256(Rational.Rational256({
            n: r.n.mul(u),
            d: r.d
        }));
    }

    /**
     * @dev Converts rational to uint256.
     * Warning: may be rounding error.
     */
    function toUInt256(Rational.Rational256 memory r) internal pure returns (uint256) {
        return r.n.div(r.d);
    }

}
