pragma solidity^0.4.18;

import './SofaContract.sol';
import './SafeMath.sol';

contract SofaStoreContract is SofaContract {
  using SafeMath for uint;

  modifier assureOwnerShip(uint _sofaId) {
    require(msg.sender == sofaToOwner[_sofaId]);
    _;
  }

  function transferSofa(uint _sofaId, address _newOwner)
    assureOwnerShip(_sofaId)
    public
  {
    sofaToOwner[_sofaId] = _newOwner;
  }

  function addSofaStoreSofas(string _name, uint _seats) {
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
