
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:music/pages/account.dart';
import 'package:music/pages/mix.dart';
import 'package:music/pages/recent.dart';
import 'package:music/pages/today.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  List<int> recentlyPlayedIndices = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }


  @override
  void dispose() {
    tabController.dispose();
    // Firebase.instance.signOut();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          buildHeader(screenWidth),
          Center(child: buildTabBar()),
          Expanded(
            child: TabBarView(
              controller: tabController,
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

  Widget buildHeader(double screenWidth) {
    return Padding(
      padding:  EdgeInsets.only(top: 40.0, left: 8, right: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Hi Logan,\nGood Evening",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
            },
          ),
          SizedBox(width: 10),
          InkWell(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/peace.png"),
              ),
              onTap:()
              {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>AccountPage()),);
              }
          ),
        ],
      ),
    );
  }

  Widget buildTabBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorColor: Colors.orange,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.white,
          labelStyle: TextStyle(fontSize:22, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize:18),
          indicatorWeight: 3,
          tabs:  [
            Tab(text: "For You"),
            Tab(text: "Relax"),
            Tab(text: "Workout"),
            Tab(text: "Travel"),
          ],
        ),
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
            RecentlySection()
          ],
        ),
      ),
    );
  }

  Widget buildRelaxTab() {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(padding: EdgeInsets.all(8),
      // child: PlaylistScreen(),
    );
  }
  Widget buildWorkoutTab(){
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(padding: EdgeInsets.all(8),
      // child:Workplaylist(),
    );
  }
  Widget buildTravelTab() {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(padding: EdgeInsets.all(8),
      // child: TravelPlaylist(),
    );
  }
}




// import 'dart:convert'; // For JSON parsing
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http; // HTTP client for API requests
// import 'package:music/pages/account.dart';
// import 'package:music/pages/mix.dart';
// import 'package:music/pages/recent.dart';
// // import 'package:music/pages/recentp.dart';
// import 'package:music/pages/today.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
//   late TabController tabController;
//   String fetchedSong = "No song fetched yet"; // Store fetched song details

//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 4, vsync: this);
//     tabController.addListener(handleTabChange);
//   }

//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }

//   void handleTabChange() async {
//     if (!tabController.indexIsChanging) {
//       String tabName;
//       switch (tabController.index) {
//         case 0:
//           tabName = "For You";
//           break;
//         case 1:
//           tabName = "Relax";
//           break;
//         case 2:
//           tabName = "Workout";
//           break;
//         case 3:
//           tabName = "Travel";
//           break;
//         default:
//           tabName = "Unknown";
//       }

//       // Fetch a song from the API
//       String song = await fetchSong(tabName);
//       setState(() {
//         fetchedSong = song;
//       });
//     }
//   }

//   Future<String> fetchSong(String tabName) async {
//     // Replace with your API endpoint
//     String apiUrl = 'https://api.spotify.com/v1/playlists/{3cEYpjA9oz9GiPac4AsH4n}=$tabName';

//     try {
//       final response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         // Assuming the response contains a "title" field for the song
//         return data['title'] ?? "No song title available";
//       } else {
//         return "Failed to fetch song";
//       }
//     } catch (e) {
//       return "Error fetching song: $e";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         children: [
//           buildHeader(MediaQuery.of(context).size.width),
//           Center(child: buildTabBar()),
//           Expanded(
//             child: TabBarView(
//               controller: tabController,
//               children: [
//                 buildForYouTab(),
//                 buildRelaxTab(),
//                 buildWorkoutTab(),
//                 buildTravelTab(),
//               ],
//             ),
//           ),
//           // Display fetched song at the bottom
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               "Fetched Song: $fetchedSong",
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildHeader(double screenWidth) {
//     return Padding(
//       padding: EdgeInsets.only(top: 40.0, left: 8, right: 8),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               "Hi Logan,\nGood Evening",
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.notifications, color: Colors.white),
//             onPressed: () {},
//           ),
//           SizedBox(width: 10),
//           InkWell(
//             child: CircleAvatar(
//               backgroundImage: AssetImage("assets/images/peace.png"),
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AccountPage()),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildTabBar() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0, bottom: 10),
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.8,
//         child: TabBar(
//           controller: tabController,
//           isScrollable: true,
//           indicatorColor: Colors.orange,
//           labelColor: Colors.orange,
//           unselectedLabelColor: Colors.white,
//           labelStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           unselectedLabelStyle: TextStyle(fontSize: 18),
//           indicatorWeight: 3,
//           tabs: [
//             Tab(text: "For You"),
//             Tab(text: "Relax"),
//             Tab(text: "Workout"),
//             Tab(text: "Travel"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildForYouTab() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             FeaturingToday(),
//             MixesForYou(),
//             RecentlySection()
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildRelaxTab() {
//     return Padding(padding: EdgeInsets.all(8));
//   }

//   Widget buildWorkoutTab() {
//     return Padding(padding: EdgeInsets.all(8));
//   }

//   Widget buildTravelTab() {
//     return Padding(padding: EdgeInsets.all(8));
//    }
// }

