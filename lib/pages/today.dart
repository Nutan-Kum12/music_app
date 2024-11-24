import 'package:flutter/material.dart';

// FeaturingToday Widget
class FeaturingToday extends StatelessWidget {
  final List<Map<String, String>> featuringTodayList = [
    {'title': 'English Songs', 'image': 'assets/images/unsplash.png'},
    {'title': 'Top Hits', 'image': 'assets/images/unsplash.png'},
    {'title': 'Jazz Classics', 'image': 'assets/images/unsplash.png'},
    {'title': 'Chill Vibes', 'image': 'assets/images/unsplash.png'},
    {'title': 'Workout Beats', 'image': 'assets/images/unsplash.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Featuring Today',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height * 0.025,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: featuringTodayList
                .map((item) => _buildFeatureCard(item, context))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(Map<String, String> item, BuildContext context) {
     final double screenHeight = MediaQuery.of(context).size.height;
      final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: InkWell(
        onTap: () {
          if (item['title'] == 'English Songs') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EnglishSongsPage(),
              ),
            );
          } else if (item['title'] == 'Top Hits') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TopHitsPage(),
              ),
            );
          } else if (item['title'] == 'Jazz Classics') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JazzClassicsPage(),
              ),
            );
          } else if (item['title'] == 'Chill Vibes') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChillVibesPage(),
              ),
            );
          } else if (item['title'] == 'Workout Beats') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkoutBeatsPage(),
              ),
            );
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              // Background image
              Image.asset(
                item['image']!,
                width: screenWidth*0.6,
                height: screenHeight*0.16,
                fit: BoxFit.cover,
              ),
              // Text overlay
              Positioned(
                bottom: 10,
                left: 10,
                child: Text(
                  item['title']!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 3,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EnglishSongsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("English Songs")),
      body: Center(child: Text("Welcome to English Songs!")),
    );
  }
}

class TopHitsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Top Hits")),
      body: Center(child: Text("Welcome to Top Hits!")),
    );
  }
}

class JazzClassicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jazz Classics")),
      body: Center(child: Text("Welcome to Jazz Classics!")),
    );
  }
}

class ChillVibesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chill Vibes")),
      body: Center(child: Text("Welcome to Chill Vibes!")),
    );
  }
}

class WorkoutBeatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Workout Beats")),
      body: Center(child: Text("Welcome to Workout Beats!")),
    );
  }
}
