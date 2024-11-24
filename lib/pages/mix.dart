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
    return Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: InkWell(
        onTap: () {
          if (mix['title'] == 'Mix 1') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TabPage(),
              ),
            );
          } else if (mix['title'] == 'Mix 2') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Padding(padding: EdgeInsets.only(top: 60) ,child: TabPage()),
              ),
            );
          } else if (mix['title'] == 'Mix 3') {
            Navigator.push(
              context,
               MaterialPageRoute(
                builder: (context) => Padding(padding: EdgeInsets.only(top: 60) ,child: TabPage()),
              ),
            );
          } else if (mix['title'] == 'Mix 4') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Padding(padding: EdgeInsets.only(top: 60) ,child: TabPage()),
              ),
            );
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 120,
            height: 160, 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image section
                Expanded(
                  flex: 3,
                  child: Image.asset(
                    mix['image']!,
                    width: 120,
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


class Mix1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mix 1")),
      body: Center(child: Text("Welcome to Mix 1!")),
    );
  }
}

class Mix2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mix 2")),
      body: Center(child: Text("Welcome to Mix 2!")),
    );
  }
}

class Mix3Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mix 3")),
      body: Center(child: Text("Welcome to Mix 3!")),
    );
  }
}

class Mix4Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mix 4")),
      body: Center(child: Text("Welcome to Mix 4!")),
    );
  }
}
