import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'spotify_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchPage(),
    );
  }
}

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
          readOnly: true, // making search bar editable
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
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Categories',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
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

  // Build search results list with playback
  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final track = _searchResults[index];
        return ListTile(
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
            onPressed: () => _playPreview(track['preview_url']!),
          ),
        );
      },
    );
  }
}
