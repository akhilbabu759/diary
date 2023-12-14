import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairyheart/features/driver/home/botto_nav/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class DriverDataSource{
  Future<void> storeUserData(String name, String number, String vechicleName,
       String email, String password) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('DriverAcc').add({
        'name': name,
        'number': number,
        'vechicleName': vechicleName,
        
        'email': email,
        // Avoid storing password in plaintext, hash it before storing in a real app
        // For example, use Firebase Authentication to handle passwords securely
        'password': password,
      });
      Get.offAll(const BottoNav());
      if (kDebugMode) {
        print('User data stored successfully!');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error storing user data: $e');
      }
    }
  }

// Function to create a user using email and password in Firebase Authentication
  Future<UserCredential?> registerWithEmailAndPassword(
      String name,
      String number,
      String vechicleName,
     
      String email,
      String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      log(email);
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      storeUserData(
        name,
        number,
        vechicleName,
       
        email,
        password,
      );

      if (kDebugMode) {
        print('User created successfully: ${userCredential.user!.uid}');
      }
      return userCredential;
    } catch (e) {
      if(e.toString().contains('alredy')){
        Get.snackbar('email id already used', 'Entred email id already used .use login page');
      }
      if (kDebugMode) {
        print('Error creating user: $e');
      }
      return null;
    }
  }


}