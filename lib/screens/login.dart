import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Login Screen"),
          const Padding(padding: EdgeInsets.only(top: 10)),
          FilledButton(
              onPressed: () => Navigator.of(context, rootNavigator: true)
                  .pushNamed('/flight_input'),
              child: const Text("Log in"))
        ],
      ),
    );
  }
}
