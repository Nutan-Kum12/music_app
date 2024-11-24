import 'package:flutter/material.dart';
import 'package:music/pages/account.dart';
import 'package:music/pages/mix.dart';
import 'package:music/pages/playlist.dart';
import 'package:music/pages/recent.dart';
import 'package:music/pages/today.dart';
import 'package:music/screens/search.dart';
import 'package:music/screens/song.dart';
import 'package:music/screens/tab.dart';
import 'package:music/services/appwritesongs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // List of screens for BottomNavigationBar
  final List<Widget> _bottomNavScreens = [
    HomeTab(), // The main tab with the original HomeScreen content
    SearchPage(), // Search screen
    MusicPlayerScreenn(), // Library/Playlist screen
  ];

  @override
  Widget build(BuildContext context) {
      final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(
        index: _currentIndex,
        children: _bottomNavScreens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Switch BottomNavigationBar tabs
          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
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

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this); // Initialize TabController
  }

  @override
  void dispose() {
    tabController.dispose(); // Dispose the tabController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          buildHeader(context),
          buildTabBar(context),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 8, right: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Hi Logan,\nGood Evening",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle notifications
            },
          ),
          SizedBox(width: 10),
          InkWell(
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/peace.png"),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage()));
            },
          ),
        ],
      ),
    );
  }

  Widget buildTabBar(BuildContext context) {
      final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    return Expanded(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            child: TabBar(
              controller: tabController, // Pass the tabController here
              isScrollable: true,
              indicatorColor: Colors.orange,
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.white,
              labelStyle: TextStyle(fontSize:screenWidth*0.03 , fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: screenWidth*0.027),
              indicatorWeight: 3,
              tabs: [
                Tab(text: "For You"),
                Tab(text: "Relax"),
                Tab(text: "Workout"),
                Tab(text: "Travel"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController, // Pass the tabController here
              children: [
                buildForYouTab(),
                buildRelaxTab(),
                buildWorkoutTab(),
                buildTravelTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForYouTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            FeaturingToday(),
            MixesForYou(),
            RecentlySection(),
            MixesForYou()
          ],
        ),
      ),
    );
  }

  Widget buildRelaxTab() {
    return TabPage();
  }

  Widget buildWorkoutTab() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TabPage(),
    );
  }

  Widget buildTravelTab() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TabPage(),
    );
  }
}
