import 'dart:io';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:navigair/dealer.dart';
import 'package:navigair/speech2text.dart';
import 'package:navigair/text2speech.dart';
import 'package:navigair/theme.dart';
import 'package:navigair/utils.dart';

class ServicesWidget extends StatefulWidget {
  int pageNumber;
  LatLng? servicePosition;

  static const services = [
    "Bathroom",
    "Restaurant",
    "Shop",
    "Security Control",
    "Boarding Door",
    "Coffee"
  ];

  ServicesWidget({required this.pageNumber, super.key});

  @override
  State<ServicesWidget> createState() => ServicesWidgetState();
}

class ServicesWidgetState extends State<ServicesWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showMicrophone(context);
      Speech2Text().listenMessage(setState, func: () async {
        final String? text = Speech2Text().getLastListenedMessage();

        print("Message: $text");

        if (text != null) {
          for (var service in ServicesWidget.services) {
            if (text.toLowerCase().contains(service.toLowerCase())) {
              var (position, name) = await Dealer.getServiceCoords(service);
              widget.servicePosition = position;
              if (widget.servicePosition == null) {
                Text2Speech().speak("Sorry, no $service found nearby.");
              } else {
                var distance = 3;
                Text2Speech().speak(
                    "Found a $name nearby. Follow the compass to get there.");
              }
            }
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Text2Speech().speak("What service are you looking for?");

    final LatLng boardingDoorNextLocation =
        Dealer.getBoardingDoorNextLocation();

    return CarouselPage(
      pageNumber: widget.pageNumber,
      title: "Services",
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(top: 30)),
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
