import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:navigair/screens/boarding_pass.dart';
import 'package:navigair/screens/flight_info.dart';
import 'package:flutter/material.dart';
import 'package:navigair/screens/personal_info.dart';
import 'package:navigair/screens/user_details.dart';
import 'package:navigair/screens/services.dart';
import 'package:navigair/speech2text.dart';
import 'package:navigair/text2speech.dart';
import 'package:navigair/utils.dart';

class HomeScreen extends StatefulWidget {
  UserDetailsArguments details;

  HomeScreen({required this.details});

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

  final PageController _pageController = PageController(
    // If changed, change also the Text2Speech at route_generator.dart
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
          showMicrophone(context);
          Speech2Text().listenMessage(setState, func: () {
            var text = Speech2Text().getLastListenedMessage();

            // print(text);

            if (text != null) {
              for (var entry in pageTitles.entries) {
                if (text.toLowerCase().contains(entry.value.toLowerCase())) {
                  currentIndex = entry.key;
                  _pageController.animateToPage(
                    currentIndex,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear,
                  );
                  break;
                }
              }
            }

            Navigator.of(context).pop();
          });
        }
      },
      onVerticalDragUpdate: (details) {
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
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear,
            );

            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.insert_drive_file_outlined),
              label: pageTitles[0],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.trending_up),
              label: pageTitles[1],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.flight),
              label: pageTitles[2],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.design_services_outlined),
              label: pageTitles[3],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.help),
              label: pageTitles[4],
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
            PersonalInfoScreen(userDetails: widget.details),
            BoardingPass(userDetails: widget.details),
            FlightInfoWidget(pageNumber: 3),
            ServicesWidget(pageNumber: 4),
            CarouselPage(
              pageNumber: 5,
              title: "Ask for help",
              body: Center(
                child: FilledButton(
                  onPressed: () {
                    Text2Speech().speak(
                        "Calling the assistance service of the airport. They will be with you in a minute");
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(100),
                    backgroundColor: Colors.red[900],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    "HELP",
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
