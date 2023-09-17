import 'package:boot_navigation/view/screen/Home.dart';
import 'package:boot_navigation/view/screen/Person.dart';
import 'package:boot_navigation/view/screen/print.dart';
import 'package:boot_navigation/view/screen/settings.dart';
import 'package:flutter/material.dart';

import '../model/basicTile.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});
  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  late final BasicTile tile;
  String _screen = "Home";
  int currentselected = 0;
  List<Map<String, dynamic>> listItem = [
    {
      "name": "Home",
      "icons": const Icon(
        Icons.home,
        size: 25,
      )
    },
    {
      "name": "Person",
      "icons": const Icon(
        Icons.person,
        size: 25,
      )
    },
    {
      "name": "Print",
      "icons": const Icon(
        Icons.print,
        size: 25,
      )
    },
    {
      "name": "Setting",
      "icons": const Icon(
        Icons.settings,
        size: 25,
      )
    },
  ];
  Widget _renderScreen(String screen) {
    switch (screen) {
      case "Home":
        return const HomeScreen();
      case "Person":
        return const PersonView();
      case "Print":
        return PrintView();
      case "Setting":
        return const SettingView();

      default:
        return const HomeScreen();
    }
  }

  onBottomNavigationTap(int index) {
    setState(() {
      currentselected = index;
      switch (currentselected) {
        case 0:
          _screen = "Home";
          return;
        case 1:
          _screen = "Person";
          return;
        case 2:
          _screen = "Print";
          return;
        case 3:
          _screen = "Setting";
          return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _renderScreen(_screen),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: const Color(0xFF323D5B),
        selectedItemColor: Colors.purple,
        currentIndex: currentselected,
        unselectedItemColor: Colors.grey,
        items: [
          for (int i = 0; i < listItem.length; i++)
            BottomNavigationBarItem(
                icon: listItem[i]['icons'], label: listItem[i]["name"])
        ],
        onTap: (index) {
          onBottomNavigationTap(index);
        },
      ),
    );
  }
}
