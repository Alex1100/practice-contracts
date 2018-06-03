pragma solidity 0.4.18;

contract SofaContract {

  struct Sofa {
    string name;
    uint seats;
  }

  Sofa[] sofas;
  mapping(uint => address) sofaToOwner;

  modifier isOwner(uint _id) {
    require(msg.sender == sofaToOwner[_id]);
    _;
  }

  function addSofa(string _name, uint _seats) public returns (uint) {
    address owner = msg.sender;
    uint id = sofas.push(Sofa(_name, _seats));
    sofaToOwner[id] = owner;
    return id;
  }

  function getSofa(uint _id) isOwner(_id) view public returns (string) {
    return sofas[_id - 1].name;
  }
}
