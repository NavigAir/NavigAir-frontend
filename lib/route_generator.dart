import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigair/screens/flight_input.dart';
import 'package:navigair/screens/home_screen.dart';
import 'package:navigair/screens/login.dart';
import 'package:navigair/screens/start.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/carousel':
        return CupertinoPageRoute(builder: (_) => HomeScreen());
      case '/login':
        return CupertinoPageRoute(builder: (_) => LoginScreen());
      case '/start':
        return CupertinoPageRoute(builder: (_) => StartScreen());
      case '/flight_input':
        return CupertinoPageRoute(builder: (_) => FlightInputScreen());
      default:
        return errorRoute(settings.name);
    }
  }

  static Route<dynamic> errorRoute(String? name) {
    return CupertinoPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(child: Text('Unknown page name $name')),
      ),
    );
  }
}
