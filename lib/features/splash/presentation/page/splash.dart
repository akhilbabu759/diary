import 'package:dairyheart/features/auth/login/presentation/page/login.dart';

//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class Splash extends StatelessWidget {
   Splash({super.key});


  @override
  Widget build(BuildContext context) {
   
    return AnimatedSplashScreen(
      backgroundColor: const Color.fromARGB(255, 250, 246, 246),
      splash: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Center(
            child: Image.asset(
              'assets/OIGty.jpeg',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
          ),
          const Text(
            'DairyHunt',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color.fromARGB(255, 147, 147, 147),
                fontStyle: FontStyle.italic),
          )
        ]),
      ),
      nextScreen:const LoginPage()  ,
      splashIconSize: MediaQuery.of(context).size.height * 0.5,
    );
  }
//    navigateToNextScreen() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
//     bool usercheck = prefs.getBool('usercheck') ?? true;
// User? use=FirebaseAuth.instance.currentUser;
//     // Check if it's the first time the app is launched
//     if (isFirstTime || use==null) {
//       // If it's the first time, set isFirstTime to false and navigate to WelcomeScreen
//       await prefs.setBool('isFirstTime', false);
//    wid=
//        LoginPage();
        
      
//     } else {
//       if(usercheck){
//       // If it's not the first time, navigate to HomeScreen or any other desired screen
//      wid= RetailHome();
        
//       }else{
         
//         wid=   DriverHome();
       

//       }
//     }
//   }
}
