import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:navigair/dealer.dart';
import 'package:navigair/theme.dart';

class FlightInfoWidget extends StatelessWidget {
  int pageNumber;

  FlightInfoWidget({required this.pageNumber, super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime flightHourDeparture = Dealer.getFlightHourDeparture();
    final DateTime boardingDoorOpenHour = Dealer.getBoardingDoorOpenHour();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: CustomPaint(
            size: const Size.fromHeight(0),
            painter: BottomAppBarPainter(context: context, number: pageNumber),
          ),
        ),
        title: Text(
          "Flight Info",
          style: TextStyle(fontSize: mainFontSize, fontWeight: FontWeight.w500),
          textScaler: const TextScaler.linear(1.5),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
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
              destination: LatLng(41.313109, 2.015360),
            ),
          ],
        ),
      ),
    );
  }
}

class Compass extends StatefulWidget {
  LatLng destination;
  LatLng? currentPosition;

  Compass({super.key, required this.destination});

  @override
  State<Compass> createState() => CompassState();
}

class CompassState extends State<Compass> {
  @override
  void initState() {
    super.initState();
    _setCurrentPosition();
  }

  void _setCurrentPosition() async {
    final Position pos = await Geolocator.getCurrentPosition();
    widget.currentPosition = LatLng(pos.latitude, pos.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FlutterCompass.events,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error reading heading: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          _setCurrentPosition();

          return _buildCompass(context, snapshot);
        });
  }

  Widget _buildCompass(BuildContext context, snapshot) {
    double? direction = snapshot.data!.heading;

    // if direction is null, then device does not support this sensor
    // show error message
    if (direction == null) {
      return const Center(
        child: Text("Device does not have sensors!"),
      );
    }

    if (widget.currentPosition == null) {
      return const Center(child: CircularProgressIndicator());
    }

    double bearing = direction +
        Geolocator.bearingBetween(
            widget.currentPosition!.latitude,
            widget.currentPosition!.longitude,
            widget.destination.latitude,
            widget.destination.longitude);

    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/compass_background.png',
          fit: BoxFit.contain,
          color: Theme.of(context).colorScheme.secondary,
          scale: 2.3,
        ),
        Transform.rotate(
          angle: (bearing * (pi / 180)),
          child: Image.asset(
            'assets/compass.png',
            fit: BoxFit.contain,
            scale: 1.2,
          ),
        ),
      ],
    );
  }
}

class BottomAppBarPainter extends CustomPainter {
  BuildContext context;
  int number;

  BottomAppBarPainter({required this.context, required this.number});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Theme.of(context).colorScheme.primary
      ..strokeWidth = 20;

    Offset start = Offset(0, size.height / 2);
    Offset end = Offset(size.width, size.height / 2);

    canvas.drawLine(start, end, paint);

    final Offset center = Offset(size.width / 2, size.height / 2);
    const Offset numberOffset = Offset(14, 27);

    canvas.drawCircle(center, 40, paint);

    var style = const TextStyle(fontSize: 50);

    final ParagraphBuilder paragraphBuilder = ParagraphBuilder(ParagraphStyle())
      ..pushStyle(style.getTextStyle())
      ..addText('$number');

    final Paragraph paragraph = paragraphBuilder.build()
      ..layout(ParagraphConstraints(width: size.width));
    canvas.drawParagraph(paragraph, center - numberOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class InfoBox extends StatelessWidget {
  final Widget child;

  const InfoBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          color: Theme.of(context).colorScheme.surface,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: child,
      ),
    );
  }
}
