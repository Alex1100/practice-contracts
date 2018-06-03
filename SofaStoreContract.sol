pragma solidity 0.4.18;

import './SofaContract.sol';
import './SafeMath.sol';

/*
  assert() will burn the gas
  while require() is a soft
  error handling approach
  that will return remaning gas to
  function invoker if something is
  wrong
*/

/*
  Mutatin value of state on the blockchain
  costs gas or money

  Reads that don't mutate state on the network
  are completely free

  To lower gas costs for mutating functions
  use the correct uint type

  for instance for dealig with a person or
  properties age, use uint8 for only allocating
  8 bits
  max value for uint8 is 256 aka 11111111 == 256
*/

contract BankInterface {
  function getBalance() public view returns (uint);
  function deposit() public payable;
}

contract SofaStoreContract is SofaContract {
  using SafeMath for uint;

  modifier assureOwnerShip(uint _sofaId, address _newOwner) {
    require(msg.sender == sofaToOwner[_sofaId] && msg.sender != _newOwner);
    _;
  }

  modifier costs(uint _value) {
    require (msg.value >= _value);
    _;
  }

  BankInterface BankContract;

  function initBank(address_bankAddress) onlyOwner {
    BankContract = BankInterface(_bankAddress);
  }

  function transferSofa(uint _sofaId, address _newOwner)
    assureOwnerShip(_sofaId, _newOwner)
    costs(100)
    payable
    public
  {
    sofaToOwner[_sofaId] = _newOwner;
    BankContract.deposit.value(msg.value)();
  }

  function getBalance() public view returns (uint) {
    return BankContract.getBalance();
  }

  function addSofaStoreSofas(string _name, uint _seats) public {
    addSofa(_name, _seats);
  }

  function findAverageSeatsOnSofas() view public returns(uint) {
    uint sofaSum = 0;
    for(uint i = 0; i < sofas.length; i++) {
        sofaSum = SafeMath.add(sofaSum, sofas[i].seats);
    }

    return SafeMath.div(sofaSum, sofas.length);
  }
}
