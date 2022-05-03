pragma solidity >=0.4.16 <0.9.0;

contract HotelRoom {
    // Ether - pay smart contracts
    // Modifiers
    // Visibility
    // Events
    // Enums


    //Vacant
    //Occupied
    enum Statuses { Vacant, Occupied }
    Statuses currentStatus;

    event Occupy(address _occupant, uint _value);

    address payable public owner;

    // created only when smart contract is deployed (Once and only once)  
      constructor() public {
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant {
        require(currentStatus == Statuses.Vacant, "Currently Occupied!");
        _;
    }

    modifier costs(uint _amount){
        require(msg.value >= _amount, "Not enough Ether Provided.");
        _;
    }

    receive() external payable onlyWhileVacant costs(2 ether){
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }
 
}
