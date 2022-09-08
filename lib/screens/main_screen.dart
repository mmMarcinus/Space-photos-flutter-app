import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:space_pictures_app/screens/home_screen.dart';
import 'package:space_pictures_app/screens/starting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = const [HomeScreen(), UserScreen()];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
          height: 60,
          selectedIndex: _currentIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: <NavigationDestination>[
            NavigationDestination(icon: Icon(Icons.rocket), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.person), label: 'User')
          ]),
    );
  }
}
