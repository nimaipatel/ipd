pragma solidity ^0.8.0;

contract Main{
    enum RideStatus {
        Booked,
        InProgress,
        Completed,
        Cancelled
    }
    // ^ enum for Ride RideStatus
    // Booked - Ride is Booked but it hasn't started yet
    // InProgress - Rider and Driver are travelling to the Destination
    // Completed - The Ride has been completed and the payment is successful
    // Cancelled - Ride was cancelled before it could begin
    
    int256 public rideCount = 0;
    mapping (int256 => Ride) public Rides;
    
    struct coordinates{
        int256 latitude;
        int256 longitude;
    }
    
    struct Ride{
        int256 rideId;
        address riderAddress;
        address driverAddress;
        RideStatus rideState;
        coordinates pickupLocation;
        coordinates dropoffLocation;
        uint256 bookingTime;
        uint256 rideStartTime;
        uint256 rideEndTime;
        uint256 rideCost;
    }
    
    function initRideBlock() public{
        Rides[rideCount] = Ride({
            rideId : rideCount,
            riderAddress: msg.sender,
            driverAddress: 0x0000000000000000000000000000000000000000,
            rideState : RideStatus.Booked, 
            pickupLocation: coordinates({latitude: 0, longitude: 0}),
            dropoffLocation: coordinates({latitude: 0, longitude: 0}),
            bookingTime: block.timestamp,
            rideStartTime: 0,
            rideEndTime: 0,
            rideCost: 1 ether
        });
        rideCount += 1;
    }
    
    function pairRiderDriver(address payable _driverAddress, int256 rideNo) public{
        require(Rides[rideNo].driverAddress == 0x0000000000000000000000000000000000000000);
        require(Rides[rideNo].rideState == RideStatus.Booked);
        Rides[rideNo].driverAddress = _driverAddress;
    }
    
    function startRide(int256 rideNo) public{
        require(Rides[rideNo].driverAddress != 0x0000000000000000000000000000000000000000);
        require(Rides[rideNo].rideState == RideStatus.Booked);
        Rides[rideNo].rideState = RideStatus.InProgress;
        Rides[rideNo].rideStartTime = block.timestamp;
    }
    
    function endRide(int256 rideNo, address payable transferAddress) public payable{
        require(Rides[rideNo].rideState == RideStatus.InProgress);
        Rides[rideNo].rideState = RideStatus.Completed;
        Rides[rideNo].rideEndTime = block.timestamp;
        transferAddress.transfer(Rides[rideNo].rideCost);
    }
}
