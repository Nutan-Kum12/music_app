import 'package:flutter/material.dart';
import 'package:music/pages/playlist.dart';
import 'package:music/screens/song.dart';

class RecentlySection extends StatelessWidget {
  final List<Map<String, String>> editorsPicks = [
    {'title': 'Ed Sheeran', 'imageUrl': 'assets/images/peace.png'},
    {'title': 'Castle On the Hill', 'imageUrl': 'assets/images/peace.png'},
    {'title': 'Charli XC', 'imageUrl': 'assets/images/music.jpg'},
    {'title': 'Tame Impala', 'imageUrl': 'assets/images/peace.png'},
    {'title': 'Africa', 'imageUrl': 'assets/images/peace.png'},
    {'title': 'Good Life', 'imageUrl': 'assets/images/music.jpg'},
    {'title': 'Wanderlust', 'imageUrl': 'assets/images/music.jpg'},
    {'title': 'Chasing Cars', 'imageUrl': 'assets/images/peace.png'},
  ];

  @override
  Widget build(BuildContext context) {
      final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recently Played',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height * 0.025,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: MediaQuery.of(context).size.height * 0.23,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: editorsPicks.length,
              itemBuilder: (context, index) {
                final item = editorsPicks[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>MusicPlayerScree(
                          title: 'Sleeping N9ght',
                          imageUrl: 'assets/images/mix2.png',
                        )
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        width: MediaQuery.of(context).size.height * 0.14,
                        height: MediaQuery.of(context).size.height * 0.12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(item['imageUrl']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                        item['title']!,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


