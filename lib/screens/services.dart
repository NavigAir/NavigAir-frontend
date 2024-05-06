import 'dart:io';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:navigair/dealer.dart';
import 'package:navigair/speech2text.dart';
import 'package:navigair/text2speech.dart';
import 'package:navigair/theme.dart';
import 'package:navigair/utils.dart';

class ServicesWidget extends StatefulWidget {
  final GlobalKey _popupKey = GlobalKey();
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool should_continue = true;
        showMicrophone(context, key: widget._popupKey, then: (_) {
          Text2Speech().stop();
          should_continue = false;
        });
        Text2Speech().speak("What service are you looking for?");
        Future.delayed(const Duration(seconds: 2), () {
          if (!should_continue) return;
          Speech2Text().listenMessage(setState, func: () async {
            final String? text = Speech2Text().getLastListenedMessage();

            print("Message: $text");

            if (widget._popupKey.currentContext != null) {
              print("Inside popup");
            }

            if (text != null) {
              for (var service in ServicesWidget.services) {
                if (text.toLowerCase().contains(service.toLowerCase())) {
                  var (position, name) = await Dealer.getServiceCoords(service);
                  widget.servicePosition = position;
                  if (widget.servicePosition == null) {
                    Text2Speech().speak("Sorry, no $service found nearby.");
                  } else {
                    Text2Speech().speak(
                        "Found a $name nearby. Follow the compass to get there.");
                  }
                }
              }
            }
            if (widget._popupKey.currentContext != null) {
              Navigator.of(context).pop();
            }
          });
        });
      },
      child: CarouselPage(
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
                destination: widget.servicePosition ?? const LatLng(0, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
