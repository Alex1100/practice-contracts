pragma solidity 0.4.18;


// WRONG WAY
// CONTRACT IS EXPOSED TO RE-ENTRY ATTACK
// Re-Entry is when a contract calls another contracts function
// again, before the previous interaction has finished

contract Fund {
  mapping(address => uint) shares;

  function withdraw() public {
    if (msg.sender.send(shares[msg.sender])
      shares[msg.sender] = 0;
  }
}


/*
  DEVELOPMENT PATTERN
  CHECKS-EFFECTS-INTERACTIONS
*/


// CORRECT WAY
contract Fund {
  // Mapping of ether shares of the contract
  mapping(address => uint256) shares;
  // Withdraw your shares
  function withdraw() public {
    var share = shares[msg.sender];
    shares[msg.sender] = 0;
    msg.sender.transfer(share);
  }
}


// LOOPS WITHOUT FIXED NUMBER OF ITERATIONS

// NEVER USE TX.ORIGIN FOR AUTH -- USE MSG.SENDER
// PEOPLE COULD PROXY TRANSACTIONS AND ACT AS YOUR CONTRACT


// FAIL SAFE MODE
