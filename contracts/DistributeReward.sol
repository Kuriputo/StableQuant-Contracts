// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract DistributeReward {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    address public constant owner = 0xa77c870379906FC95F408dc294c1660Ad73f28e2; // 4.5%
    address public constant person = 0x5E5ea2Ca21d87Ace30739232A79b43582D8Eca70; // 0.5%
    address public constant admin = 0x57AB1e535353D853537E49e2E53E678d5f8561d2; // 1%
    address public constant dev = 0x70Ea2A0F638c9502be2e0fD5028599193a9D4B63; // 4%
    IERC20 public quant;

    constructor(address _quant) public {
        quant = IERC20(_quant);
    }

    function distribute() external {
        uint256 balance = IERC20(quant).balanceOf(address(this));
        uint256 ownerReward = balance.mul(45).div(100);
        uint256 personReward = balance.mul(5).div(100);
        uint256 adminReward =  balance.mul(10).div(100);
        uint256 devReward =  ((balance.sub(ownerReward)).sub(personReward)).sub(adminReward);

        quant.safeTransfer(owner, ownerReward);
        quant.safeTransfer(person, personReward);
        quant.safeTransfer(admin, adminReward);
        quant.safeTransfer(dev, devReward);
    }
}
