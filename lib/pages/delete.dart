import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:music/auth.dart';
import 'package:music/pages/register_page.dart';

class DeleteAccountScreen extends StatefulWidget {
  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  // final AuthService _authService = AuthService(); 
  final TextEditingController _passwordController = TextEditingController();

Future deleteAccount(BuildContext context) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  try {
    User? user = _auth.currentUser;
    
    if (user != null) {
      await user.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account deleted successfully.")),
      );
      
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterPage())); // Replace '/auth' with your authentication page route
      
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No user is currently signed in.")),
      );
      return false;
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error deleting account: $e")),
    );
    return false;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
              bool result = await deleteAccount(context);
              if (!result) {
              print("Account deletion failed.");
              }
              },          
              child: Text("Delete Account"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
