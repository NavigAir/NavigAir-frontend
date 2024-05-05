import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class StartScreen extends StatefulWidget {
  @override
  State<StartScreen> createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  bool _hasLocationPermission = false;
  bool _hasMicrophonePermission = false;

  @override
  void initState() {
    super.initState();
    _fetchLocationPermissionStatus();
    _fetchMicrophonePermissionStatus();
  }

  void _fetchLocationPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() {
          _hasLocationPermission = (status == PermissionStatus.granted);
        });
      }
    });
  }

  void _fetchMicrophonePermissionStatus() {
    Permission.microphone.status.then((status) {
      if (mounted) {
        setState(() {
          _hasMicrophonePermission = (status == PermissionStatus.granted);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Permission Check'),
        ),
        body: Builder(
          builder: (context) {
            if (_hasLocationPermission && _hasMicrophonePermission) {
              return _buildStartScreen(); // Main content
            } else {
              return _buildPermissionSheet(); // Permission sheet
            }
          },
        ),
      ),
    );
  }

  Widget _buildStartScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Are you at the airport?',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/flight_input');
              print('Start button pressed');
            },
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(), // Round button
              padding: EdgeInsets.all(50), // Large button size
            ),
            child: Text(
              'Start',
              style: TextStyle(
                fontSize: 20.0, // Larger text for visibility
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionSheet() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Vertical centering
        crossAxisAlignment: CrossAxisAlignment.center, // Horizontal centering
        children: [
          Text(
            'This application requires access to location and microphone.',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center, // Center text alignment
          ),
          SizedBox(height: 20.0), // Spacing between elements
          ElevatedButton(
            onPressed: () {
              Permission.locationWhenInUse.request().then((status) {
                _fetchLocationPermissionStatus(); // Update permission status
              });
              Permission.microphone.request().then((status) {
                _fetchMicrophonePermissionStatus(); // Update permission status
              });
            },
            child: Text('Request Permissions'),
          ),
        ],
      ),
    );
  }
}
