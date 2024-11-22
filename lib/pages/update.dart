import 'package:flutter/material.dart';
import 'package:music/auth.dart';
import 'package:music/pages/register_page.dart'; // Assuming you have an AuthService class and AuthScreen

class UpdatePasswordScreen extends StatefulWidget {
  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final AuthService _authService = AuthService(); // Instance of AuthService
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  bool _oldPasswordVisible = false;  // Toggle visibility of the old password
  bool _newPasswordVisible = false;  // Toggle visibility of the new password

  void _updatePassword() async {
    String oldPassword = _oldPasswordController.text.trim();
    String newPassword = _newPasswordController.text.trim();

    if (oldPassword.isEmpty || newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter both old and new passwords")),
      );
      return;
    }

    bool success = await _authService.changePassword(oldPassword, newPassword);

    if (success) {
      // After successful password update, navigate to the Auth screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>RegisterPage()), // Assuming AuthScreen exists
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password updated successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update password. Try again.")),
      );
    }
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Old password field with eye icon
            TextField(
              controller: _oldPasswordController,
              decoration: InputDecoration(
                labelText: "Old Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    _oldPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _oldPasswordVisible = !_oldPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_oldPasswordVisible,
            ),
            SizedBox(height: 16),
            // New password field with eye icon
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: "New Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    _newPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _newPasswordVisible = !_newPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_newPasswordVisible,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updatePassword,
              child: Text("Update Password"),
            ),
          ],
        ),
      ),
    );
  }
}
