import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'spotify_service.dart';





class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SpotifyService _spotifyService = SpotifyService();
  final TextEditingController _searchController = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();

  String? _accessToken;
  List<Map<String, String>> _categories = [];
  List<Map<String, String>> _searchResults = [];
  bool isLoading = false;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); 
    super.dispose();
  }

 
  Future<void> _initialize() async {
    setState(() {
      isLoading = true;
    });

    try {
      final token = await _spotifyService.fetchAccessToken();
      final categoriesResponse = await _spotifyService.fetchCategories(token);

      // Safely parse categories
      final categories = (categoriesResponse as List).map((category) {
        return {
          'label': category['label']?.toString() ?? 'Unknown Category',
          'image': category['image']?.toString() ?? '',
        };
      }).toList().cast<Map<String, String>>();

      setState(() {
        _accessToken = token;
        _categories = categories;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error initializing: $e');
    }
  }

  // Perform search
  Future<void> _performSearch(String query) async {
    if (_accessToken == null || query.isEmpty) return;

    setState(() {
      isLoading = true;
      isSearching = true;
    });

    try {
      final searchResponse = await _spotifyService.searchTracks(query, _accessToken!);

      // Safely parse search results
      final results = (searchResponse as List).map((track) {
        return {
          'name': track['name']?.toString() ?? 'Unknown Track',
          'artist': track['artist']?.toString() ?? 'Unknown Artist',
          'image': track['image']?.toString() ?? '',
          'preview_url': track['preview_url']?.toString() ?? '',
        };
      }).toList().cast<Map<String, String>>();

      setState(() {
        _searchResults = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error performing search: $e');
    }
  }

  void _clearSearch() {
    setState(() {
      _searchResults = [];
      isSearching = false;
      _searchController.clear();
    });
  }

  Future<void> _playPreview(String previewUrl) async {
    if (previewUrl.isEmpty) {
      print('No preview URL available');
      return;
    }

    try {
      await _audioPlayer.setUrl(previewUrl);
      _audioPlayer.play();
    } catch (e) {
      print('Error playing preview: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          // readOnly: true, // making search bar editable
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for tracks...',
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
            suffixIcon: isSearching
                ? IconButton(
              icon: Icon(Icons.clear, color: Colors.grey[400]),
              onPressed: _clearSearch,
            )
                : null,
            filled: true,
            fillColor: Colors.grey[800],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
          ),
          onSubmitted: _performSearch,
        ),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : isSearching
          ? _buildSearchResults()
          : _buildCategories(),
      backgroundColor: Colors.black,
    );
  }

 
  Widget _buildCategories() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.height;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Categories',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth*0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.4,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return GestureDetector(
                  onTap: () {
                    // Implement category-specific functionality here
                  },
                  child: Image.network(
                    // height:screenHeight*0.12,
                    // width: screenWidth*0.4,
                    category['image']!,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

   
Widget _buildSearchResults() {
  return ListView.builder(
    itemCount: _searchResults.length,
    itemBuilder: (context, index) {
      final track = _searchResults[index];
      return Card(
        child: ListTile(
          leading: Image.network(
            track['image']!,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.music_note,
                size: 50,
                color: Colors.grey,
              );
            },
          ),
          title: Text(track['name']!, style: TextStyle(color: Colors.white)),
          subtitle: Text(track['artist']!, style: TextStyle(color: Colors.grey)),
          trailing: IconButton(
            icon: Icon(Icons.play_arrow, color: Colors.green),
            onPressed: () {
              // Navigate to the MusicPlayerScreen with the current track
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicPlayerScreen(
                    tracks: _searchResults,
                    initialTrackIndex: index,
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}  
}






class MusicPlayerScreen extends StatefulWidget {
  final List<Map<String, String>> tracks;
  final int initialTrackIndex;

  MusicPlayerScreen({required this.tracks, required this.initialTrackIndex});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late AudioPlayer _audioPlayer;
  late int _currentTrackIndex;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playTrack();
    _currentTrackIndex = widget.initialTrackIndex;
    _initializePlayer();
  }

  void _initializePlayer() {
    final track = widget.tracks[_currentTrackIndex];
    final previewUrl = track['preview_url'] ?? '';

    if (previewUrl.isEmpty) {
      print('No preview URL available');
      return;
    }

    _audioPlayer.setUrl(previewUrl);

    // Listen for changes in duration
    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _totalDuration = duration ?? Duration.zero;
      });
    });

    // Listen for changes in position
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });


    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.processingState == ProcessingState.ready &&
            state.playing;
      });
    });

     _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _nextTrack(); 
      }
    });
  }

  void _playTrack() async {
    await _audioPlayer.play();
    setState(() {
      _isPlaying = true;
    });
  }

  void _pauseTrack() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  void _nextTrack() {
    if (_currentTrackIndex < widget.tracks.length - 1) {
      setState(() {
        _currentTrackIndex++;
      });
      _initializePlayer();
      _playTrack();
    }
  }

  void _previousTrack() {
    if (_currentTrackIndex > 0) {
      setState(() {
        _currentTrackIndex--;
      });
      _initializePlayer();
      _playTrack();
    }
  }

  void _seekToPosition(double value) {
    final position = Duration(seconds: value.toInt());
    _audioPlayer.seek(position);
  }

  @override
  void dispose() {
    
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    final track = widget.tracks[_currentTrackIndex];
    return Scaffold( 
      body: Padding(
        padding:  EdgeInsets.only(top:screenHeight*0.08),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: 
                  [
                    IconButton(onPressed: ()
                    {
                      Navigator.pop(context);
                    },
                     icon: Icon(Icons.keyboard_arrow_down_sharp,size: 34,)
                     ),
                     SizedBox(width: screenWidth*0.5),
                    IconButton(onPressed: ()
                    {
                      Navigator.pop(context);
                    },
                     icon: Icon(Icons.close_rounded)
                     )
                  ],
                ),
                SizedBox(height: 40),
                 Text(
                  track['name']!,
                  style: TextStyle(color: Colors.white, fontSize: screenHeight*0.02),
                ),
                Padding(
                  padding: EdgeInsets.all(35),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.network(
                      track['image']!,
                      height: screenHeight*0.3,
                      // width: screenWidth*.5,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.music_note,
                          size: 100,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
                Text(
                  track['name']!,
                  style: TextStyle(color: Colors.white, fontSize: screenHeight*0.015),
                ),
                Text(
                  track['artist']!,
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                SizedBox(height: 20),
               
            
                Slider(
                  value: _currentPosition.inSeconds.toDouble(),
                  min: 0,
                  max: _totalDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    _seekToPosition(value);
                  },
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey,
                ),
                SizedBox(height: 20),
                Text(
                  '${_currentPosition.inMinutes}:${_currentPosition.inSeconds % 60}'.padLeft(5, '0') +
                      ' / ' +
                      '${_totalDuration.inMinutes}:${_totalDuration.inSeconds % 60}'.padLeft(5, '0'),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  IconButton(
                      icon: Icon(Icons.skip_previous, color: Colors.white,size: 35,),
                      onPressed: _previousTrack,
                    ),
                     SizedBox(width: 20),
                   CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.green,
                    child: IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      // color: Colors.green,
                      size: 25,
                      
                    ),
                    onPressed: _isPlaying ? _pauseTrack : _playTrack,
                              ),
                  ),
                   SizedBox(width: 20),
                    IconButton(
                      icon: Icon(Icons.skip_next, color: Colors.white,size: 34,),
                      onPressed: _nextTrack,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
