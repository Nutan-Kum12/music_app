import 'dart:convert';
import 'package:http/http.dart' as http;

class SpotifyService {
  final String clientId = '6eb7c0bfed5b4c2b8b1071f017d9ac9f';
  final String clientSecret = '78d36409e54d40b78b4178046ffdc1ad';

  Future<String> fetchAccessToken() async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic ' +
            base64Encode(utf8.encode('$clientId:$clientSecret')),
      },
      body: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['access_token'];
    } else {
      throw Exception('Failed to fetch access token');
    }
  }

  Future<List<Map<String, String>>> fetchCategories(String accessToken) async {
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/browse/categories?limit=10'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final categories = (data['categories']['items'] as List)
          .map((item) => {
        'label': item['name'] as String,
        'image': item['icons'][0]['url'] as String,
      })
          .toList();
      return categories;
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  Future<List<Map<String, String>>> searchTracks(String query, String accessToken) async {
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/search?q=$query&type=track&limit=10'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final tracks = (data['tracks']['items'] as List)
          .map((item) => {
        'name': item['name'] ?? 'Unknown Track',
        'artist': (item['artists']?.isNotEmpty ?? false)
            ? (item['artists'][0]['name'] ?? 'Unknown Artist')
            : 'Unknown Artist',
        'image': (item['album']['images']?.isNotEmpty ?? false)
            ? (item['album']['images'][0]['url'] ?? '')
            : '',
        'preview_url': item['preview_url'] ?? '',
      })
          .toList()
          .cast<Map<String, String>>(); // Explicitly cast the list to List<Map<String, String>>
      return tracks;
    } else {
      throw Exception('Failed to search tracks');
    }
  }

}
