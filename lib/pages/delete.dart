import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music/auth.dart';
import 'package:music/pages/register_page.dart';
// Import the AuthService class

class DeleteAccountScreen extends StatefulWidget {
  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final AuthService _authService = AuthService(); // Instance of AuthService
  final TextEditingController _passwordController = TextEditingController();

Future deleteAccount(BuildContext context) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  try {
    User? user = _auth.currentUser;
    
    if (user != null) {
      await user.delete();
      // Show success message using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account deleted successfully.")),
      );
      
      // Navigate to the Auth page (login/signup)
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterPage())); // Replace '/auth' with your authentication page route
      
      return true;
    } else {
      // No user is signed in
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No user is currently signed in.")),
      );
      return false;
    }
  } catch (e) {
    // Catch any errors and show them in a SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error deleting account: $e")),
    );
    return false;
  }
}
  //  Future<bool> deleteAccount() async {
  //    final FirebaseAuth _auth = FirebaseAuth.instance;
  //   try {
  //     User? user = _auth.currentUser;
  //     if (user != null) {
  //       await user.delete();
  //       print("Account deleted successfully.");
  //       return true;
  //     }
  //     print("No user is currently signed in.");
  //     return false;
  //   } catch (e) {
  //     print("Error deleting account: $e");
  //     return false;
  //   }
  // }

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
