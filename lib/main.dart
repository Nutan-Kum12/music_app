import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:music/firebase_options.dart';
import 'package:music/screens/splash_screen.dart';
import 'package:music/themes/dark.dart';


void main()
  async{
     WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify Clone',
      theme: spotifyDarkMode,
      home: SplashScreen(),

      // routes: {
      //   "/": (context) => SplashScreen(),      // Splash Screen
      //   "/register": (context) => RegisterPage(),  // Registration Page
      //   "/login": (context) => LoginPage(),    // Login Page
      //   "/signup": (context) => SignUpPage(),  // Sign-Up Page
      //   "/home": (context) => Homepage(),

      // },

    );
  }
}




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Spotify Song Search')),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: const InputDecoration(
//                 labelText: 'Search for a song',
//                 border: OutlineInputBorder(),
//               ),
//               onSubmitted: _searchSongs,
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _songs.length,
//               itemBuilder: (context, index) {
//                 final song = _songs[index];
//                 return ListTile(
//                   title: Text(song['name']),
//                   subtitle: Text(song['artists'][0]['name']),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.play_arrow),
//                     onPressed: () => _playPreview(song['preview_url']),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }
// }
//
