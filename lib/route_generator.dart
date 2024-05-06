import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigair/screens/flight_input.dart';
import 'package:navigair/screens/home_screen.dart';
import 'package:navigair/screens/login.dart';
import 'package:navigair/screens/start.dart';
import 'package:navigair/screens/personal_info.dart';
import 'package:navigair/screens/signup_screen.dart';
import 'package:navigair/screens/user_details.dart';
import 'package:navigair/text2speech.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/carousel':
        if (args is UserDetailsArguments) {
          Text2Speech().speak("Personal Info");
          return CupertinoPageRoute(
              settings: settings,
              builder: (_) => HomeScreen(
                    details: args,
                  ));
        } else {
          return errorRoute('${settings.name} with args: $args');
        }
      case '/login':
        return CupertinoPageRoute(
            settings: settings, builder: (_) => LoginScreen());
      case '/start':
        if (args is UserDetailsArguments) {
          return CupertinoPageRoute(
              settings: settings,
              builder: (_) => StartScreen(
                    details: args,
                  ));
        } else {
          return errorRoute('${settings.name} with args: $args');
        }
      case '/flight_input':
        if (args is UserDetailsArguments) {
          return CupertinoPageRoute(
              settings: settings,
              builder: (_) => FlightInputScreen(
                    details: args,
                  ));
        } else {
          return errorRoute('${settings.name} with args: $args');
        }
      case '/signup':
        return CupertinoPageRoute(
            settings: settings, builder: (_) => SignupScreen());
      case '/user_details':
        if (args is UserDetailsArguments) {
          return CupertinoPageRoute(
              settings: settings,
              builder: (_) => UserDetailsScreen(
                    details: args,
                  ));
        } else {
          return errorRoute('${settings.name} with args: $args');
        }
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
