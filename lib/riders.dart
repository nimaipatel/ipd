import 'package:web3dart/credentials.dart';

class AwaitingRider {
  String name;
  int projectedTime;
  String fromLocation;
  String toLocation;

  AwaitingRider(
      this.name, this.projectedTime, this.fromLocation, this.toLocation);
}

// used in contractlinking
class Coordinates {
  double latitude;
  double longitude;

  Coordinates(this.latitude, this.longitude);
}

class Ride {
  BigInt rideID;
  EthereumAddress riderAddress;
  EthereumAddress driverAddress;
  // RideStatus rideState;
  Coordinates pickupLocation;
  Coordinates dropoffLocation;
  BigInt bookingTime;
  BigInt rideStartTime;
  BigInt rideEndTime;
  BigInt rideCost;

  Ride(
      this.rideID,
      this.riderAddress,
      this.driverAddress,
      // this.rideState,
      this.pickupLocation,
      this.dropoffLocation,
      this.bookingTime,
      this.rideStartTime,
      this.rideEndTime,
      this.rideCost);
}

// used in choose drivers

class Driver {
  BigInt driverID;
  EthereumAddress driverAddress;
  String driverName;
  BigInt driverMobile;
  String carRegistration;
  String carMake;
  String carModel;
  Coordinates currentLocation;

  Driver(
      this.driverID,
      this.driverAddress,
      this.driverName,
      this.driverMobile,
      this.carMake,
      this.carModel,
      this.carRegistration,
      this.currentLocation
      );
}
