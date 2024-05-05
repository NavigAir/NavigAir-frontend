// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:navigair/screens/flight_info.dart';
import 'package:flutter/material.dart';
import 'package:navigair/speech2text.dart';
import 'package:navigair/talk_screen.dart';
import 'package:navigair/text2speech.dart';
import 'package:navigair/utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool swipingDown = false;

  static const Map<int, String> pageTitles = {
    0: "Personal Info",
    1: "Boarding Pass",
    2: "Flight Info",
    3: "Services",
    4: "Ask for Help",
  };

  PageController _pageController = PageController(
    initialPage: 0,
  );
  int currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Text2Speech.speak(pageTitles[_pageController.initialPage]!);
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (swipingDown) {
          showCupertinoModalPopup(
              context: context,
              builder: (context) => Padding(
                    padding: EdgeInsets.only(bottom: 100),
                    child: AvatarGlow(
                        animate: true,
                        glowColor: Theme.of(context).primaryColor,
                        // endRadius: 75.0,
                        duration: const Duration(milliseconds: 2000),
                        // repeatPauseDuration: const Duration(milliseconds: 100),
                        repeat: true,
                        child: Container(
                            child: Icon(
                          Icons.mic,
                          size: 100,
                        ))),
                  ));
        }
      },
      onVerticalDragUpdate: (details) {
        print("DragUpdate: ${details.delta.dy}");
        swipingDown = details.delta.dy < 0;
      },
      child: Scaffold(
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
            BottomNavigationBarItem(
              icon: Icon(Icons.abc_rounded),
              label: "stt",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.abc_rounded),
              label: "tts",
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (page) {
            Text2Speech().speak(pageTitles[page]!);
            setState(() {
              currentIndex = page;
            });
          },
          children: <Widget>[
            FlightInfoWidget(pageNumber: 1),
            CarouselPage(
              pageNumber: 2,
              title: "Boarding Pass",
              body: Column(
                children: [
                  FilledButton(
                      onPressed: () => HapticFeedback.lightImpact(),
                      child: Text("Light Impact")),
                  FilledButton(
                      onPressed: () => HapticFeedback.mediumImpact(),
                      child: Text("Medium Impact")),
                  FilledButton(
                      onPressed: () => HapticFeedback.heavyImpact(),
                      child: Text("Heavy Impact")),
                  FilledButton(
                      onPressed: () => HapticFeedback.vibrate(),
                      child: Text("Vibrate Impact")),
                ],
              ),
            ),
            CarouselPage(
              pageNumber: 3,
              title: "Page 3",
              body: Column(
                children: [
                  FilledButton(
                    child: Text("Speech2Text"),
                    onPressed: () => Speech2Text().listenMessage(setState),
                  ),
                  Text(Speech2Text().getLastListenedMessage() ??
                      "No message yet :("),
                ],
              ),
            ),
            CarouselPage(pageNumber: 4, title: "Page 4"),
            CarouselPage(pageNumber: 4, title: "Page 5"),
            TalkScreen(),
          ],
        ),
      ),
    );
  }
}
