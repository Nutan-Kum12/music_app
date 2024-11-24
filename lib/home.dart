
import 'package:flutter/material.dart';

import 'package:music/pages/home_page.dart';
import 'package:music/pages/playlist.dart';
import 'package:music/screens/search.dart';

class Homepage extends StatefulWidget {
   Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  
  bool isLoading = true;
  int currentIndex = 0;

  final List<Widget> pages = [
        HomeScreen(),
        SearchPage(),
        // MusicPlayerScreen()
        
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:isLoading
          ? Center(child: CircularProgressIndicator())
          : IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex:currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_outlined),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}
