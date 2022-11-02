import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:space_pictures_app/screens/home_screen.dart';
import 'package:space_pictures_app/screens/user_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        initialData: FirebaseAuth.instance.currentUser,
        builder: (context, authSnapshot) {
          List<Widget> screens = authSnapshot.hasData
              ? [HomeScreen(true), UserDataScreen(true)]
              : [HomeScreen(false), UserDataScreen(false)];
          return Scaffold(
            backgroundColor: const Color(0xfff8f9fa),
            body: screens[_currentIndex],
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(width: 1, color: Color(0xff212529))),
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(10),
                //     topRight: Radius.circular(10)),
              ),
              child: NavigationBar(
                  animationDuration: const Duration(milliseconds: 1500),
                  backgroundColor: const Color(0xfff8f9fa),
                  height: 60,
                  selectedIndex: _currentIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  destinations: const <NavigationDestination>[
                    NavigationDestination(
                      icon: Icon(
                        Icons.rocket_rounded,
                        color: Color(0xff212529),
                      ),

                      // icon: FaIcon(
                      //   FontAwesomeIcons.rocket,
                      //   color: Color(0xff212529),
                      // ),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: FaIcon(
                        FontAwesomeIcons.userAstronaut,
                        color: Color(0xff212529),
                      ),
                      label: 'User',
                    )
                  ]),
            ),
          );
        });
  }
}
