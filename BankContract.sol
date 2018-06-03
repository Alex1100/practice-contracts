pragma solidity 0.4.18;


contract BankContract {
  uint balance;

  function deposit() payable public {
    balance += msg.value;
  }

  function getBalance()
  view
  public
  returns (uint)
  {
    return balance;
  }
}
