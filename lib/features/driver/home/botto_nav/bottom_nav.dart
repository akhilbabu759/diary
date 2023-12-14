import 'package:dairyheart/features/driver/home/botto_nav/accepted.dart';
import 'package:dairyheart/features/driver/home/botto_nav/controller/botto_nav_controller.dart';
import 'package:dairyheart/features/driver/home/deleverd.dart';
import 'package:dairyheart/features/driver/home/driver_home.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottoNav extends StatelessWidget {
  const BottoNav({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavController());
       const List<Widget> widgetOptions = <Widget>[
    DriverHome(),
    AcceptedPage(),
    DeleverdPage(),
  ];
    return  Scaffold(
      body: GetBuilder<BottomNavController>(builder:(controller) {
        return widgetOptions[controller.slecetdindex];
      }),
      bottomNavigationBar: GetBuilder<BottomNavController>(
        builder: (control) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wrong_location),
                label: 'Accepted',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.where_to_vote_sharp),
                label: 'Deleverd',
              ),
            ],
            currentIndex: control.slecetdindex,
            selectedItemColor: const Color.fromARGB(255, 100, 5, 140),
            onTap: (value) {
              control.indexChange(value);
              
            },
          );
        }
      ),
    

    );
  }
}