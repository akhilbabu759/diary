import 'package:dairyheart/features/auth/login/presentation/page/login.dart'; // Import the Login page

//import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package (commented out)

import 'package:flutter/material.dart'; // Flutter material package
import 'package:animated_splash_screen/animated_splash_screen.dart'; // Animated splash screen package

class Splash extends StatelessWidget {
   Splash({super.key}); // Constructor for Splash widget (parameters should be named and typed)

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: const Color.fromARGB(255, 250, 246, 246), // Background color of the splash screen
      splash: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Center(
            child: Image.asset(
              'assets/OIGty.jpeg', // Display an image as the splash screen
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
          ),
          const Text(
            'DairyHunt', // Display text 'DairyHunt' with specific styling
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color.fromARGB(255, 147, 147, 147),
                fontStyle: FontStyle.italic),
          )
        ]),
      ),
      nextScreen: const LoginPage(), // Navigate to LoginPage after the splash screen
      splashIconSize: MediaQuery.of(context).size.height * 0.5, // Size of the splash icon
    );
  }

 
}
