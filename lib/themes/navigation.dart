import 'package:flutter/material.dart';
import 'package:music/pages/example.dart';
import 'package:music/pages/home_page.dart';
import 'package:music/pages/main.dart';
import 'package:music/pages/playlist.dart';
import 'package:music/screens/search.dart';
import 'package:music/screens/song.dart';

class NavigatorScreen extends StatefulWidget {
  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _currentIndex = 0;

  // List of screens to navigate between
  final List<Widget> _screens = [
    HomeScreen(),
    SongSearchScreen(),
    MusicPlayerScreen() // Assuming you want a PlaylistScreen for Library
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected index
          });
        },
        selectedItemColor: Colors.green, // Change selected icon color to green
        unselectedItemColor: Colors.grey, // Set the unselected icon color (optional)
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}
