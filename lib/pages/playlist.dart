import 'package:flutter/material.dart';


class Song {
  final String title;
  final String artist;
  final String asset;
  final String imageAsset;
  bool isFavorite;

  Song({
    required this.title,
    required this.artist,
    required this.asset,
    required this.imageAsset,
    this.isFavorite = false,
  });
}

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({Key? key}) : super(key: key);

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  List<Song> songs = [
    Song(
      title: "Trek upio",
      artist: "Artist 1",
      asset: "audio/song1.mp3",
      imageAsset: "assets/images/album.jpg",
    ),
    Song(
      title: "Beach nex",
      artist: "Artist 2",
      asset: "audio/song2.mp3",
      imageAsset: "assets/images/mix2.png",
    ),
    Song(
      title: "WErx Dx",
      artist: "Artist 3",
      asset: "audio/song3.mp3",
      imageAsset: "assets/images/peace.png",
    ),
    Song(
      title: "UI max",
      artist: "Artist 4",
      asset: "audio/song4.mp3",
      imageAsset: "assets/images/young.png",
    ),
    Song(
      title: "NI ubun",
      artist: "Artist 5",
      asset: "audio/song5.mp3",
      imageAsset: "assets/images/album3.png",
    ),
    Song(
      title: "LO bxxg",
      artist: "Artist 6",
      asset: "audio/song6.mp3",
      imageAsset: "assets/images/album2.png",
    ),
  ];

  void navigateToSongDetail(int index) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => SongDetailScreen(
    //       songs: songs,
    //       initialIndex: index,
    //       audioPlayer: audioPlayer,
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player',style: TextStyle(
          fontSize: 22
        ),),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => FavoriteScreen(
              //       favoriteSongs: songs.where((song) => song.isFavorite).toList(),
              //     ),
              //   ),
              // );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: songs.map((song) {
            int index = songs.indexOf(song);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      song.imageAsset,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song.title,
                          style:  TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 19
                          ),
                        ),
                        Text(
                          song.artist,
                          style: const TextStyle(color: Colors.grey,
                          fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => navigateToSongDetail(index),
                    child: const Text('Play'),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
