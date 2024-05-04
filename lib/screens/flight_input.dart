import 'package:flutter/material.dart';

class FlightInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Flight Input Screen"),
          const Padding(padding: EdgeInsets.only(top: 10)),
          FilledButton(
              onPressed: () => Navigator.of(context, rootNavigator: true)
                  .pushNamed('/start'),
              child: const Text("Start"))
        ],
      ),
    );
  }
}
