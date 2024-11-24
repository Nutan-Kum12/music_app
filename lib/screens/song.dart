import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicPlayerScree extends StatefulWidget {
  final String title;
  final String imageUrl;

  const MusicPlayerScree({Key? key, required this.title, required this.imageUrl}) : super(key: key);

  @override
  State<MusicPlayerScree> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScree> {
  double _currentSliderValue = 60; 
  final double _maxDuration = 210; 

  // Convert seconds to "MM:SS" format
  String _formatTime(double seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds.toInt() % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // Dark background
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
                  image: AssetImage('assets/images/music.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Song Title and Artist
            Column(
              children: [
                Text(
                  'Sleeping Beauty',
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
                  'Tablo (Epik High)',
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
                  value: _currentSliderValue,
                  min: 0,
                  max: _maxDuration,
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatTime(_currentSliderValue),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        _formatTime(_maxDuration),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Player Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.shuffle, color: Colors.white),
                Icon(Icons.skip_previous, color: Colors.white, size: 32),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.play_arrow, color: Colors.white, size: 30),
                ),
                Icon(Icons.skip_next, color: Colors.white, size: 32),
                Icon(Icons.repeat, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
