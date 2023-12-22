// Import necessary packages and files
import 'package:dairyheart/features/splash/presentation/page/splash.dart'; // Import the Splash page (not provided in the snippet)
import 'package:dairyheart/firebase_options.dart'; // Firebase configuration options (not shown)
import 'package:firebase_core/firebase_core.dart'; // Firebase core package
import 'package:flutter/material.dart'; // Flutter material package
import 'package:get/get.dart'; // GetX package for state management and navigation

// Asynchronous function to initialize the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Initialize Firebase with provided options
  );
  runApp(const MyApp()); // Run the app by calling the MyApp widget
}

// MyApp class, the root widget of the Flutter application
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor for MyApp widget

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // GetX's GetMaterialApp widget
      debugShowCheckedModeBanner: false, // Disable debug banner
      home: Splash(), // Set the initial screen of the app to Splash page (not provided in the snippet)
    );
  }
}
