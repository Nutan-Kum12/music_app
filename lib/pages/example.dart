// import 'dart:convert'; // For JSON decoding
// import 'package:http/http.dart' as http; // For API requests
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart'; // For playing audio

// void main() {
//   runApp(const SpotifyApp());
// }

// class SpotifyApp extends StatelessWidget {
//   const SpotifyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SongSearchScreen(),
//     );
//   }
// }

// class SongSearchScreen extends StatefulWidget {
//   @override
//   _SongSearchScreenState createState() => _SongSearchScreenState();
// }

// class _SongSearchScreenState extends State<SongSearchScreen> {
//   final String clientId = 'your_client_id';
//   final String clientSecret = 'your_client_secret';
//   final TextEditingController _searchController = TextEditingController();
//   String? _accessToken;
//   List<dynamic> _songs = [];
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   @override
//   void initState() {
//     super.initState();
//     _authenticateSpotify();
//   }

//   Future<void> _authenticateSpotify() async {
//     final response = await http.post(
//       Uri.parse('https://accounts.spotify.com/api/token'),
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: 'grant_type=client_credentials&client_id=$clientId&client_secret=$clientSecret',
//     );

//     if (response.statusCode == 200) {
//       final jsonResponse = json.decode(response.body);
//       setState(() {
//         _accessToken = jsonResponse['access_token'];
//       });
//     } else {
//       throw Exception('Failed to authenticate with Spotify');
//     }
//   }

//   Future<void> _searchSongs(String query) async {
//     if (_accessToken == null) {
//       return;
//     }

//     final response = await http.get(
//       Uri.parse('https://api.spotify.com/v1/search?q=$query&type=track'),
//       headers: {'Authorization': 'Bearer $_accessToken'},
//     );

//     if (response.statusCode == 200) {
//       final jsonResponse = json.decode(response.body);
//       setState(() {
//         _songs = jsonResponse['tracks']['items'];
//       });
//     } else {
//       throw Exception('Failed to search songs');
//     }
//   }

//   void _playPreview(String? previewUrl) {
//     if (previewUrl != null) {
//       _audioPlayer.play(previewUrl as Source);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Preview not available for this track')),
//       );
//     }
//   }

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

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }
// }
