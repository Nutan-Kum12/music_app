import 'package:flutter/material.dart';
import 'package:music/pages/home_page.dart';
import 'package:music/pages/login_page.dart';
import 'package:music/pages/signup_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: Image.asset("assets/images/music.jpg",fit: BoxFit.cover,),
              
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 SizedBox(height: 20),
                  Text(
                        'Millions of Songs.',
                        style: TextStyle(
                          fontSize:  MediaQuery.of(context).size.height * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Free on Musico..',
                        style: TextStyle(
                          fontSize:  MediaQuery.of(context).size.height * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                    // Handle Sign Up button press
                    print('Sign Up clicked');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () {
                    // Handle Continue with Google button press
                    print('Continue with Google clicked');
                  },
                  style: OutlinedButton.styleFrom(
                    padding:  EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.white),
                  ),
                  icon: const Icon(Icons.g_mobiledata, color: Colors.white),
                  label: const Text(
                    'Continue with Google',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () {
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>HomeScreen()));
                    
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.blue),
                  ),
                  icon: const Icon(Icons.facebook, color: Colors.blue),
                  label: const Text(
                    'Continue with Facebook',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 14),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                      // print('Login clicked');
                    },
                    child:  Text(
                      'Login',
                      style: TextStyle(
                      
                        fontSize: 26,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
