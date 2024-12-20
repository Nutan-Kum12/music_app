import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music/pages/home_page.dart';
import 'package:music/pages/register_page.dart';
import 'package:music/pages/signup_page.dart';
import 'package:music/themes/navigation.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();

  }

   checkLogin() async {
    await Future.delayed(Duration(seconds: 3));
    User? user =FirebaseAuth.instance.currentUser;
   if(user!=null)
   {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
   }
   else{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
   }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://storage.googleapis.com/pr-newsroom-wp/1/2018/11/Spotify_Logo_RGB_White.png',
              width: 200,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

