pragma solidity ^0.5.16;

contract DriversContract {
    uint256 public driverCount;

    struct driver {
        uint256 id;
        string name;
        string carMake;
        string regNumber;
        string email;
        string resAddress;
    }

    mapping(uint256 => driver) public driverPool;

    event driverAdded(uint256 _id, string _name, string _carMake, string _regNumber, string _email, string _resAddress);

    constructor() public {
        driverCount = 0;
    }

    function addDriver(
        string memory _name,
        string memory _carMake,
        string memory _regNumber,
        string memory _email,
        string memory _resAddress
    ) public {
        driverCount++;
        driverPool[driverCount] = driver(
            driverCount,
            _name,
            _carMake,
            _regNumber,
            _email,
            _resAddress
        );
        emit driverAdded(driverCount, _name, _carMake, _regNumber, _email, _resAddress);
    }
}
