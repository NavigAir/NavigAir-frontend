// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:navigair/screens/flight_info.dart';
import 'package:navigair/screens/default.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController(
    initialPage: 0,
  );
  int currentIndex = 0;

  Widget childWidget = DefaultPageWidget(
    number: AvailableNumber.First,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[500],
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;
          _pageController.animateToPage(
            value,
            duration: Duration(milliseconds: 200),
            curve: Curves.linear,
          );

          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "First",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: "Second",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Third",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit_rounded),
            label: "Fourth",
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            currentIndex = page;
          });
        },
        children: <Widget>[
          FlightInfoWidget(pageNumber: 1),
          DefaultPageWidget(number: AvailableNumber.Second),
          DefaultPageWidget(number: AvailableNumber.Third),
          DefaultPageWidget(number: AvailableNumber.Fourth)
        ],
      ),
    );
  }
}
