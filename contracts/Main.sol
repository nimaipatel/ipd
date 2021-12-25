pragma solidity ^0.5.16;

contract Main {
    struct eligibleDrivers {
        address[] drivers;
        uint256 amount;
        address payable finalDriver;
        bool userConfirmation;
        bool driverConfirmation;
    }

    mapping (address => eligibleDrivers) perUserTable;
    address payable[] activeUsers;

    // FUNCTION TO ONLY ADD THE USER IF NOT ALREADY ADDED
    function addUser(address payable userAdd) private {
        for (uint256 i = 0; i < activeUsers.length; ++i) {
            if (activeUsers[i] == userAdd) {
                return;
            }
        }
        activeUsers.push(userAdd);
    }

    function clearDrivers(address userAdd) private {
        delete perUserTable[userAdd].drivers;
    }

    function finalizeDriver (address payable driverAdd, address userAdd) public {
        perUserTable[userAdd].finalDriver = driverAdd;
        clearDrivers(userAdd);
    }

    function addDriver(
        address payable userAdd,
        address payable driverAdd
    ) public {
        perUserTable[userAdd].drivers.push(driverAdd);
        perUserTable[userAdd].userConfirmation = false;
        perUserTable[userAdd].driverConfirmation = false;
        // ADD USER IF NOT ALREADY ADDED
        addUser(userAdd);
    }

    function getEliDrivers(address userAdd) public view returns (address[] memory) {
        return perUserTable[userAdd].drivers;
   }

   function stageDriverStatus(address payable driverAdd) public {
        for (uint256 i = 0; i < activeUsers.length; ++i) {
            address payable currUser = activeUsers[i];
            eligibleDrivers currUserTable = perUserTable[currUser];
            for (uint256 j = 0; j < currUserTable.drivers.length; ++j) {

            }
        }
   }
}
