import 'package:flutter/material.dart';
import 'package:music/pages/delete.dart';
import 'package:music/pages/forget.dart';
import 'package:music/pages/update.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String storeName = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  
   loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      storeName = prefs.getString('storeName') ?? 'Logan Ji'; // Default value if not found
      email = prefs.getString('email') ?? 'jim_logan01@g'; // Default value if not found
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        // backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              // Edit functionality here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            CircleAvatar(
              radius: 50,
              child: Image.asset("assets/images/logan.png"),
            ),
            SizedBox(height: 16),
            Text(
              storeName,
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Email',
                  style: TextStyle(color: Colors.grey),
                ),
                Spacer(),
                Text(
                  email,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Phone Number',
                  style: TextStyle(color: Colors.grey),
                ),
                Spacer(),
                Text(
                  '8844662200',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileStat('120 songs', Icons.favorite),
                ProfileStat('12 playlists', Icons.queue_music),
                ProfileStat('3 artists', Icons.person),
              ],
            ),
            SizedBox(height: 24),
            Divider(color: Colors.grey),
            SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'Settings',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Music Languages
            Row(
              children: [
                Text(
                  'Music Language(s)',
                  style: TextStyle(color: Colors.grey),
                ),
                Spacer(),
                Text(
                  'English, Tamil',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Streaming Quality',
                  style: TextStyle(color: Colors.grey),
                ),
                Spacer(),
                Text(
                  'HD',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              child: ElevatedButton(
                onPressed: () {
                   // Update Password
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>UpdatePasswordScreen()));
                },
                child: Text("Update Password"),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>DeleteAccountScreen()));
                },
                child: Text("Delete Account"),
              ),
            ),
            // Container(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Handle Delete Account
            //       Navigator.push(context, MaterialPageRoute(builder:(context)=>ForgotPasswordScreen()));
            //     },
            //     child: Text("Forget Password"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String label;
  final IconData icon;

  ProfileStat(this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}
