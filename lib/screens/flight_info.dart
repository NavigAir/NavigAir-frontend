import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:navigair/dealer.dart';
import 'package:navigair/theme.dart';
import 'package:navigair/utils.dart';

class FlightInfoWidget extends StatelessWidget {
  int pageNumber;

  FlightInfoWidget({required this.pageNumber, super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime flightHourDeparture = Dealer.getFlightHourDeparture();
    final DateTime boardingDoorOpenHour = Dealer.getBoardingDoorOpenHour();
    final LatLng boardingDoorNextLocation =
        Dealer.getBoardingDoorNextLocation();

    return CarouselPage(
      pageNumber: pageNumber,
      title: "Flight Info",
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(top: 40)),
            // Boarding time
            DateTime.now().isBefore(boardingDoorOpenHour)
                ? InfoBox(
                    child: Text(
                      "Boarding starts at ${boardingDoorOpenHour.hour < 10 ? "0" : ""}${boardingDoorOpenHour.hour}:${boardingDoorOpenHour.minute < 10 ? "0" : ""}${boardingDoorOpenHour.minute}",
                      style: TextStyle(fontSize: mainFontSize),
                      textAlign: TextAlign.center,
                    ),
                  )
                : InfoBox(
                    child: Text(
                      "Boarding has already started",
                      style: TextStyle(fontSize: mainFontSize),
                      textAlign: TextAlign.center,
                    ),
                  ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            // Gate info
            InfoBox(
              child: Text(
                "Gate ${Dealer.getBoardingDoor()}",
                style: TextStyle(fontSize: mainFontSize),
                textAlign: TextAlign.center,
              ),
            ),
            // Compass
            Compass(
              destination: boardingDoorNextLocation,
            ),
          ],
        ),
      ),
    );
  }
}
