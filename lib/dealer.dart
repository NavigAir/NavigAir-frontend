import 'package:latlong2/latlong.dart';

class Dealer {
  static final userId = 0;

  static DateTime getFlightHourDeparture() {
    return DateTime.utc(2024, 5, 5, 15, 35);
  }

  static DateTime getBoardingDoorOpenHour() {
    return DateTime.utc(2024, 5, 5, 15, 5);
  }

  static String getBoardingDoor() {
    return "32B";
  }

  static LatLng getBoardingDoorNextLocation() {
    return const LatLng(41.313109, 2.015360);
  }

  static bool checkLogin(email, password) {
    return false;
  }
}
