import 'package:flutter/material.dart';
import 'package:navigair/dealer.dart';
import 'package:intl/intl.dart';

// Function to convert the date format to a more readable form
String convertDate(String dateStr) {
  try {
    final date = DateTime.parse(dateStr);
    // Format date as "15th of June, 2024"
    final formattedDate = DateFormat("d'th of 'MMMM, yyyy").format(date);
    return formattedDate;
  } catch (e) {
    // Return the input if there's an error with parsing
    return dateStr;
  }
}

// Dummy data provider that returns flight information based on flight name
class DummyFlightData {
  static final Map<String, Map<String, dynamic>> _flightInfo = {
    'AA123': {
      'departureCity': 'New York',
      'arrivalCity': 'Los Angeles',
      'departureTime': '10:00 AM',
      'arrivalTime': '1:00 PM',
      'distance': '2475 miles',
      'duration': '6 hours',
      'date': '2024-06-15',
      'company': 'American Airlines',
      'plane': 'Boeing 747',
    },
    'BA456': {
      'departureCity': 'London',
      'arrivalCity': 'Paris',
      'departureTime': '8:00 AM',
      'arrivalTime': '9:30 AM',
      'distance': '213 miles',
      'duration': '1.5 hours',
      'date': '2024-07-10',
      'company': 'British Airways',
      'plane': 'Airbus A320',
    },
  };

  static Map<String, dynamic>? getFlightInfo(String flightName) {
    return _flightInfo[flightName];
  }
}

class FlightInputScreen extends StatefulWidget {
  @override
  _FlightInputScreenState createState() => _FlightInputScreenState();
}

class _FlightInputScreenState extends State<FlightInputScreen> {
  final TextEditingController _flightNameController = TextEditingController();
  Map<String, dynamic>? _flightInfo;
  late String flight;

  void _searchFlight() {
    final flightName = _flightNameController.text.trim();
    if (flightName.isNotEmpty) {
      final flightInfo = DummyFlightData.getFlightInfo(flightName);
      setState(() {
        _flightInfo = flightInfo;
        flight = flightName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Search'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _flightNameController,
                decoration: InputDecoration(
                  labelText: 'Flight Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'e.g., AA123',
                ),
              ),
              SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: _searchFlight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search), // Magnifying glass icon
                    SizedBox(width: 10.0), // Small space between icon and text
                    Text('Search Flight'),
                  ],
                ),
              ),
              SizedBox(height: 25.0),
              if (_flightInfo == null && _flightNameController.text.isNotEmpty)
                Text(
                  'No flight information found for "${_flightNameController.text}"',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.redAccent,
                  ),
                ),
              if (_flightInfo != null)
                FlightTicket(flightInfo: _flightInfo!),
              Spacer(), // This will push the button to the bottom
              if (_flightInfo != null)
                ElevatedButton(
                  onPressed: () {
                    // Handle what happens when "Continue" is clicked
                    Dealer.sendFlight(flight);
                    Navigator.pushNamed(context, '/start');
                  },
                  child: Text('Continue',
                   style: TextStyle(fontSize: 16.0),
                   ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _flightNameController.dispose();
    super.dispose();
  }
}

class FlightTicket extends StatelessWidget {
  final Map<String, dynamic> flightInfo;

  const FlightTicket({required this.flightInfo});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                convertDate(flightInfo['date'] ?? 'N/A'), // Format the date
                style: TextStyle(
                  fontSize: 16.0,
                  color: colorScheme.secondary,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Departure City',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: colorScheme.secondary,
                      ),
                    ),
                    Text(
                      flightInfo['departureCity'] ?? 'N/A',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: colorScheme.outline,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          flightInfo['departureTime'] ?? 'N/A',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Arrival City',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: colorScheme.secondary,
                      ),
                    ),
                    Text(
                      flightInfo['arrivalCity'] ?? 'N/A',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: colorScheme.outline,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          flightInfo['arrivalTime'] ?? 'N/A',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Center(
              child: Column(
                children: [
                  Text(
                    'Flight Duration',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: colorScheme.secondary,
                    ),
                  ),
                  Text(
                    flightInfo['duration'] ?? 'N/A',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Flight Distance',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: colorScheme.secondary,
                      ),
                    ),
                    Text(
                      flightInfo['distance'] ?? 'N/A',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      flightInfo['company'] ?? 'N/A', // Company
                      style: TextStyle(
                        fontSize: 16.0,
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      flightInfo['plane'] ?? 'N/A', // Plane type
                      style: TextStyle(
                        fontSize: 16.0,
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
