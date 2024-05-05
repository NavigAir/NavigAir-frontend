// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:navigair/screens/user_details.dart';
import 'package:navigair/utils.dart';

class PersonalInfoScreen extends StatefulWidget {
  UserDetailsArguments userDetails;

  PersonalInfoScreen({required this.userDetails});

  @override
  State<PersonalInfoScreen> createState() => PersonalInfoScreenState();
}

class PersonalInfoScreenState extends State<PersonalInfoScreen> {
  int contactLevel = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselPage(
      pageNumber: 1,
      title: "Personal Info",
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 25.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Icon(
                Icons.person_rounded,
                size: 150,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            const Divider(
              height: 0.0, // Distance from avatar to divider.
              color: Colors.black,
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            const Text(
              'NAME',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              '${widget.userDetails.name}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                letterSpacing: 2.0,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'PASSPORT',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              '${widget.userDetails.passport}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                letterSpacing: 2.0,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'AGE',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              '25 years',
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                letterSpacing: 2.0,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'VISUAL PERCENTAGE',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              '20%',
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                letterSpacing: 2.0,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'ADDRESS',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Jordi Girona nº1 08034, Barcelona',
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                letterSpacing: 2.0,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
