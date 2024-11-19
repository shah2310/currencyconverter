import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookshop/views/HomeScreen.dart';
import 'package:bookshop/views/ExchangeRatesScreen.dart';
import 'package:bookshop/views/SettingsScreen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ExchangeRatesScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedIndex(); // Load the selected index when the widget is initialized
  }

  // Load the selected index from SharedPreferences
  _loadSelectedIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedIndex = prefs.getInt('selectedIndex') ?? 0; // Default to 0 if not found
    });
  }

  // Save the selected index to SharedPreferences
  _saveSelectedIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedIndex', index);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _saveSelectedIndex(index); // Save the selected index when the user taps a tab
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange),
            label: 'Convert',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
