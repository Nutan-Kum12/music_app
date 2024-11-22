
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music/pages/login_page.dart';
import 'package:music/pages/register_page.dart';
import 'package:music/themes/dark.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'package:music/pages/profile.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String _name = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load user data when the page is created
  }

  // Function to load name and email from SharedPreferences
  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? 'Guest'; // Default to 'Guest' if not set
      _email = prefs.getString('email') ?? 'No Email'; // Default to 'No Email' if not set
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: spotifyDarkMode,
      home: Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Settings'),
          backgroundColor: Colors.grey[900],
          leading: IconButton(
            icon: Icon(Icons.arrow_back,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileSection(name: _name), // Pass the name to ProfileSection
              Divider(color: Colors.grey),
              SettingsSection(
                title: 'Account',
                options: [
                  SettingsOption(
                    title: 'Premium plan',
                    subtitle: 'View your plan',
                  ),
                  SettingsOption(
                    title: 'Email',
                    subtitle: _email, // Display the email
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              SettingsSection(
                title: 'Data Saver',
                options: [
                  ToggleOption(
                    title: 'Save Data',
                    description:
                    'Sets audio quality to low, and hides canvases as well as audio & video previews on home.',
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              SettingsSection(
                title: 'Video Podcasts',
                options: [
                  ToggleOption(title: 'Download audio only'),
                  ToggleOption(
                    title: 'Stream audio only',
                    description:
                    'Play video podcasts as audio only when not on Wi-Fi.',
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              SettingsSection(
                title: 'Playback',
                options: [
                  ToggleOption(title: 'Offline mode'),
                  SliderOption(
                    title: 'Crossfade',
                    min: 0,
                    max: 12,
                    initialValue: 6,
                    description: 'Allows you to crossfade between songs',
                  ),
                ],
              ),
              Divider(color: Colors.grey),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: Colors.red, // Button color
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: ()
                  {       
                   FirebaseAuth.instance.signOut();
            // Navigate to a login screen
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RegisterPage()),
            );
             },   
              child: Text(
                    'Logout',
                    style: TextStyle(color: Colors.white, fontSize: 16),
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

class ProfileSection extends StatelessWidget {
  final String name;

  ProfileSection({required this.name});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/profile.jpg'),
      ),
      title: Text(
        name, // Display the retrieved name here
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'View Profile',
        style: TextStyle(color: Colors.grey),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => Profile())
        );
      },
    );
  }
}

// Keep other classes (SettingsSection, SettingsOption, etc.) unchanged

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> options;

  SettingsSection({required this.title, required this.options});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          ...options,
        ],
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final String title;
  final String subtitle;

  SettingsOption({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey),
      ),
      onTap: () {
        // Add option tap logic here
      },
    );
  }
}

class ToggleOption extends StatefulWidget {
  final String title;
  final String? description;

  ToggleOption({required this.title, this.description});

  @override
  _ToggleOptionState createState() => _ToggleOptionState();
}

class _ToggleOptionState extends State<ToggleOption> {
  bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
          value: isToggled,
          activeColor: Colors.orange,
          onChanged: (value) {
            setState(() {
              isToggled = value;
            });
          },
        ),
        if (widget.description != null)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              widget.description!,
              style: TextStyle(color: Colors.grey),
            ),
          ),
      ],
    );
  }
}

class SliderOption extends StatefulWidget {
  final String title;
  final String? description;
  final double min;
  final double max;
  final double initialValue;

  SliderOption({
    required this.title,
    this.description,
    required this.min,
    required this.max,
    required this.initialValue,
  });

  @override
  _SliderOptionState createState() => _SliderOptionState();
}

class _SliderOptionState extends State<SliderOption> {
  double currentValue;

  _SliderOptionState() : currentValue = 0;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        Slider(
          value: currentValue,
          min: widget.min,
          max: widget.max,
          divisions: (widget.max - widget.min).toInt(),
          activeColor: Colors.orange,
          onChanged: (value) {
            setState(() {
              currentValue = value;
            });
          },
        ),
        if (widget.description != null)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              widget.description!,
              style: TextStyle(color: Colors.grey),
            ),
          ),
      ],
    );
  }
}

