import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class StartScreen extends StatefulWidget {
  @override
  State<StartScreen> createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();

    _fetchPermissionStatus();
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() {
          _hasPermissions = (status == PermissionStatus.granted);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Builder(
          builder: (context) {
            if (_hasPermissions) {
              return _buildScreen();
            } else {
              return _buildPermissionSheet();
            }
          },
        ),
      ),
    );
  }

  Widget _buildScreen() {
    return Center(
      child: Column(
        children: [
          const Text("Start Screen"),
          const Padding(padding: EdgeInsets.only(top: 10)),
          FilledButton(
              onPressed: () => Navigator.of(context, rootNavigator: true)
                  .pushNamed('/carousel'),
              child: const Text("Start"))
        ],
      ),
    );
  }

  Widget _buildPermissionSheet() {
    return Center(
      child: ElevatedButton(
        child: const Text('Request Permissions'),
        onPressed: () {
          Permission.locationWhenInUse.request().then((ignored) {
            _fetchPermissionStatus();
          });
        },
      ),
    );
  }
}
