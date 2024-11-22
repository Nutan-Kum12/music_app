import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in user with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error creating user: $e");
      return null;
    }
  }

    Future<User?> createUserWithEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error creating user: $e");
      return null;
    }
  }
    Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print("Error sending password reset email: $e");
      return false;
    }
  }


  // Sign out the user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }



  // Change the current user's password
 Future<bool> changePassword(String oldPassword, String newPassword) async {
  try {
    // Get the current user
    User? user = _auth.currentUser;

    if (user != null) {
      // Re-authenticate the user
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Update the password
      await user.updatePassword(newPassword);
      // print("Password updated successfully");
      return true;
    } else {
      // print("No user is currently signed in.");
      return false;
    }
  } catch (e) {
    // print("Error changing password: $e");
    return false;
  }
}
  Future<bool> deleteAccount() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();
        // print("Account deleted successfully.");
        return true;
      }
      // print("No user is currently signed in.");
      return false;
    } catch (e) {
      // print("Error deleting account: $e");
      return false;
    }
  }
}