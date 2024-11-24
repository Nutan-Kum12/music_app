import 'package:flutter/material.dart';
import 'package:music/screens/tab.dart';

// MixesForYou Widget
class MixesForYou extends StatelessWidget {
  final List<Map<String, String>> mixesForYouList = [
    {'title': 'Mix 1', 'image': 'assets/images/mix2.png'},
    {'title': 'Mix 2', 'image': 'assets/images/mix2.png'},
    {'title': 'Mix 3', 'image': 'assets/images/mix2.png'},
    {'title': 'Mix 4', 'image': 'assets/images/mix2.png'},
    {'title': 'Mix 5', 'image': 'assets/images/mix2.png'},
    {'title': 'Mix 6', 'image': 'assets/images/mix2.png'},
  ];

  @override
  Widget build(BuildContext context) {
      final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Mixes for you',
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
            children: mixesForYouList
                .map((mix) => _buildMixCard(mix, context)) 
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMixCard(Map<String, String> mix, BuildContext context) {
      final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: InkWell(
        onTap: () {
          if (mix['title'] == 'Mix 1') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Padding(padding: EdgeInsets.only(top: screenHeight*0.06) ,child: TabPage()),
              ),
            );
          } else if (mix['title'] == 'Mix 2') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Padding(padding: EdgeInsets.only(top: screenHeight*0.06) ,child: TabPage()),
              ),
            );
          } else if (mix['title'] == 'Mix 3') {
            Navigator.push(
              context,
               MaterialPageRoute(
                builder: (context) => Padding(padding: EdgeInsets.only(top: screenHeight*0.06) ,child: TabPage()),
              ),
            );
          } else if (mix['title'] == 'Mix 4') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Padding(padding: EdgeInsets.only(top: screenWidth*0.06) ,child: TabPage()),
              ),
            );
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width:screenWidth*0.3 ,
            height: screenHeight*0.16, 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image section
                Expanded(
                  flex: 3,
                  child: Image.asset(
                    mix['image']!,
                    // width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                // Title section
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey[800], 
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        mix['title']!,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}







