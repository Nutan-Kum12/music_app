import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:flutter/material.dart';
import 'package:http/http.dart' hide Client;
import 'package:just_audio/just_audio.dart';
// import 'package:music/screens/song.dart';
import 'package:google_fonts/google_fonts.dart';

class TabPage extends StatefulWidget {
  // final List<Map<String, dynamic>> favorites;

  // SongsPage({required this.favorites});

  @override
  _SongsPageState createState() => _SongsPageState();
}

class _SongsPageState extends State<TabPage> {
  final appwrite.Client client = appwrite.Client(); // Specify Appwrite's Client
  late final appwrite.Storage storage; // Use Appwrite's Storage
  late final AudioPlayer audioPlayer; // For audio playback
  List<Map<String, dynamic>> songs = [];
  String searchQuery = '';
  int? currentSongIndex;

  @override
  void initState() {
    super.initState();
    client
        .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite endpoint
        .setProject('673030910027c1f3cb2c'); // Your Appwrite project ID
    storage = appwrite.Storage(client); // Initialize Appwrite Storage
    audioPlayer = AudioPlayer(); // Initialize AudioPlayer
    fetchSongs();
  }

  Future<void> fetchSongs() async {
    try {
      final fileList = await storage.listFiles(bucketId: '6738173d002b1de9852f');
      setState(() {
        songs = List<Map<String, dynamic>>.from(
          fileList.files.map((audio) {
            return {
              'id': audio.$id,
              'name': audio.name,
              'url': 'https://cloud.appwrite.io/v1/storage/buckets/6738173d002b1de9852f/files/${audio.$id}/view?project=673030910027c1f3cb2c&mode=admin',
              // 'isFavorite': widget.favorites.any((fav) => fav['id'] == audio.$id),
            };
          }),
        );
      });
    } catch (e) {
      print('Error fetching songs: $e');
    }
  }

  
  void navigateToMusicPlayer(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MusicPlayerScrree(
          songs: songs,
          currentIndex: index,
          // favorites: widget.favorites,
          imageUrl:'image' ,
          audioPlayer: audioPlayer,
        ),
      ),
    ).then((_) {
      setState(() {});
    });
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start, 
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Text('Songs List', style: TextStyle(fontSize: 24)), // You can add a title or any other widget here if needed
        ),
        Expanded(
          child: songs.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        songs[index]['name'],
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                      onTap: () => navigateToMusicPlayer(index),
                    );
                  },
                ),
        ),
      ],
    ),
  );
}
}

class MusicPlayerScrree extends StatefulWidget {
  // final String title;
  final String imageUrl;
  final List<Map<String, dynamic>> songs;
  final int currentIndex;
  final AudioPlayer audioPlayer;

  const MusicPlayerScrree({
    Key? key,
     required this.songs,
     required this.currentIndex,
     required this.audioPlayer,
     required this.imageUrl
     }) : super(key: key);

  @override
  State<MusicPlayerScrree> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScrree> {
  late int currentIndex;
  Duration _currentPosition =Duration.zero;
  Duration _totalDuration =Duration.zero;
  bool isPlaying=false;

@override
void initState() {
  super.initState();
  currentIndex = widget.currentIndex;
  widget.audioPlayer.positionStream.listen((position) {
    setState(() {
      _currentPosition = position;
    });
  });
  widget.audioPlayer.durationStream.listen((duration) {
    setState(() {
      _totalDuration = duration ?? Duration.zero;
    });
  });

  widget.audioPlayer.playerStateStream.listen((state) {
    if (state.processingState == ProcessingState.completed) {
      playNextSong(); // Automatically play the next song
    }
  });

  playSong();
}

void playSong() async {
  await widget.audioPlayer.setUrl(widget.songs[currentIndex]['url']);
  widget.audioPlayer.play();
  setState(() {
    isPlaying = true;
  });
}

void togglePlayPause() {
  if (isPlaying) {
    widget.audioPlayer.pause();
  } else {
    widget.audioPlayer.play();
  }
  setState(() {
    isPlaying = !isPlaying;
  });
}

void playNextSong() {
  setState(() {
    currentIndex = (currentIndex + 1) % widget.songs.length;
  });
  playSong();
}

void nextSong() {
  setState(() {
    currentIndex = (currentIndex + 1) % widget.songs.length;
  });
  playSong();
}

void previousSong() {
  setState(() {
    currentIndex = (currentIndex - 1 + widget.songs.length) % widget.songs.length;
  });
  playSong();
}

void seekToPosition(double value) {
  final newPosition = Duration(seconds: value.toInt());
  widget.audioPlayer.seek(newPosition);
}

@override
void dispose() {
  widget.audioPlayer.stop();
  super.dispose();
}

  
  // void toggleFavorite() {
  //   setState(() {
  //     final song = widget.songs[currentIndex];
  //     song['isFavorite'] = !song['isFavorite'];
  //     if (song['isFavorite']) {
  //       widget.favorites.add(song);
  //     } else {
  //       widget.favorites.removeWhere((fav) => fav['id'] == song['id']);
  //     }
  //   });
  // }

  // Convert seconds to "MM:SS" format
  String formatTime(double seconds) {              
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds.toInt() % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }


  @override
  Widget build(BuildContext context) {
    final currentSong =widget.songs[currentIndex];
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50), 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.arrow_back, color: Colors.white),
                Text(
                  'Singing Now',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
               IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
               ),
              ],
            ),
            const SizedBox(height: 20),
            // Image or Album Art
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/music.jpg'), // Add your image here
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Song Title and Artist
            Column(
              children: [
                Text(
                  currentSong['name'],
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  currentSong['name'],
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Progress Bar with Usi Slider
            Column(
              children: [
                Slider(
                  value: _currentPosition.inSeconds.toDouble(),
                  min: 0,
                  max: _totalDuration.inSeconds.toDouble(),
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey,
                  onChanged: seekToPosition,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDuration(_currentPosition),
                        style:  TextStyle(color: Colors.grey),
                      ),
                      Text(
                        formatDuration(_totalDuration),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Playback controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous, size: 36),
                  onPressed: previousSong,
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green,
                  child: IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 30,
                    ),
                    onPressed: togglePlayPause,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.skip_next, size: 36),
                  onPressed: nextSong,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

