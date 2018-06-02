pragma solidity^0.4.18;

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

contract SofaStoreContract is SofaContract {
  using SafeMath for uint;

  modifier assureOwnerShip(uint _sofaId, address _newOwner) {
    require(msg.sender == sofaToOwner[_sofaId] && msg.sender != _newOwner);
    _;
  }

  function transferSofa(uint _sofaId, address _newOwner)
    assureOwnerShip(_sofaId, _newOwner)
    public
  {
    sofaToOwner[_sofaId] = _newOwner;
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
