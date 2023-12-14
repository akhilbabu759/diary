import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairyheart/features/auth/login/presentation/auth_controll.dart';
import 'package:dairyheart/features/auth/regesterstion/driver/driver_reg.dart';
import 'package:dairyheart/features/driver/home/botto_nav/bottom_nav.dart';

import 'package:dairyheart/features/retail/home/retail_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cont = Get.put(AuthCont());
    TextEditingController email = TextEditingController();
    TextEditingController pass = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthCont>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/login/background.png'),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeInUp(
                              duration: const Duration(seconds: 1),
                              child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/login/light-1.png'))),
                              )),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: FadeInUp(
                              duration: const Duration(milliseconds: 1200),
                              child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/login/light-2.png'))),
                              )),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: FadeInUp(
                              duration: const Duration(milliseconds: 1300),
                              child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/login/clock.png'))),
                              )),
                        ),
                        Positioned(
                          child: FadeInUp(
                              duration: const Duration(milliseconds: 1600),
                              child: Container(
                                margin: const EdgeInsets.only(top: 50),
                                child: Center(
                                  child: Text(
                                    "${cont.usercheck ? 'Driver ' : 'Retail '}Login",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        FadeInUp(
                            duration: const Duration(milliseconds: 1800),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          143, 148, 251, 1)),
                                  boxShadow: const [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromRGBO(
                                                    143, 148, 251, 1)))),
                                    child: TextField(
                                      controller: email,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[700])),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: pass,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[700])),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1900),
                          child: ElevatedButton(
                              onPressed: () {
                                controller.userchange(!controller.usercheck);
                              },
                              child: Text(
                                  'Login as ${cont.usercheck ? 'Retail ' : 'Driver '}')),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final FirebaseAuth firebaseAuth =
                                FirebaseAuth.instance;
                             
                            try {
                              if (email.text != '' &&
                                  pass.text != '' &&
                                  email.text.contains('@gmail.com')) {
                                await firebaseAuth.signInWithEmailAndPassword(
                                    email: email.text, password: pass.text);

                                var a = true;
                                if (controller.usercheck) {
                                  log('hai 1');
                                  QuerySnapshot orderSnapshot =
                                      await FirebaseFirestore.instance
                                          .collection('DriverAcc')
                                          .get();
                                  log('hai 2');
                                  while (a) {
                                    log('hai 3');
                                    if (orderSnapshot.docs.isNotEmpty) {
                                      log('hai 4');
                                      for (var document in orderSnapshot.docs) {
                                        log('hai 5');
                                        log(document.data().toString());
                                        log(document['email']);

                                        if (document['email'] == email.text) {
                                          log('hai 6');
                                          Get.offAll(const BottoNav());
                                         
                                          a = false;
                                        }
                                        log('hai 16');
                                      }
                                      log('hai 18');
                                      if (a) {
                                        log('hai 8');
                                        Get.snackbar('failed',
                                            'There is no account in our Dirver database ');
                                        break;
                                      } else {
                                        log('hai 7');

                                        break;
                                      }
                                    }
                                  }
                                  log('hai 9');
                                } else {
                                  QuerySnapshot orderSnapshot =
                                      await FirebaseFirestore.instance
                                          .collection('retailAcc')
                                          .get();
                                  while (a) {
                                    if (orderSnapshot.docs.isNotEmpty) {
                                      for (var document in orderSnapshot.docs) {
                                        if (document['email'] == email.text) {
                                          Get.offAll(const RetailHome());
                                          
                                          a = false;
                                        }
                                      }
                                      if (a) {
                                       Get.snackbar('failed',
                                            'There is no account in our Retail database ');
                                        break;
                                      } else {
                                        break;
                                      }
                                    }
                                  }
                                }
                              } else {
                                Get.snackbar('Enter correct email format',
                                    'Entre email and password properly');
                              }
                            } on FirebaseAuthException catch (e) {
                              Get.snackbar('Enter correct email format',
                                  'Entre email and password properly');
                              log(e.toString());
                            }
                          },
                          child: FadeInUp(
                              duration: const Duration(milliseconds: 1900),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                child: const Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const DriverReg(),
                          )),
                          child: FadeInUp(
                              duration: const Duration(milliseconds: 2000),
                              child: const Text(
                                "New User? create a account",
                                style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1)),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
