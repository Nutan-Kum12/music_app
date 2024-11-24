import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:music/firebase_options.dart';
import 'package:music/screens/splash_screen.dart';
import 'package:music/themes/dark.dart';


void main() 
  async{
     WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify Clone',
      theme: spotifyDarkMode,
      home: SplashScreen(),
    );
  }
}

