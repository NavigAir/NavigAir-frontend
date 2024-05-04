import 'package:flutter/material.dart';

class DefaultPageWidget extends StatelessWidget {
  final AvailableNumber number;

  const DefaultPageWidget({this.number = AvailableNumber.First}) : super();

  @override
  Widget build(BuildContext context) {
    String file = "";
    if (number == AvailableNumber.First) {
      file = "first";
    } else if (number == AvailableNumber.Second) {
      file = "second";
    } else if (number == AvailableNumber.Third) {
      file = "third";
    } else {
      file = "fourth";
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "$file screen",
              style: TextStyle(fontSize: 36.0),
            ),
            Flexible(child: Image.asset("assets/default.jpg"))
          ],
        ),
      ),
    );
  }
}

enum AvailableNumber { First, Second, Third, Fourth }
