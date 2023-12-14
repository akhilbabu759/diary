import 'package:dairyheart/features/retail/home/retail_home.dart';
import 'package:dairyheart/features/retail/selling_product/selling_product.dart';
import 'package:dairyheart/features/retail/settings/settings.dart';
import 'package:flutter/material.dart';

class BottoNave extends StatelessWidget {
  const BottoNave({super.key});

  @override
  Widget build(BuildContext context) {
    List wid = [const RetailHome(), const SellingProduct(), const Settings()];
    return Scaffold(
      body: wid[0],
      bottomNavigationBar: BottomNavigationBar(selectedItemColor: const Color.fromRGBO(143, 148, 251, 1),
        currentIndex: 0,
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            label: 'Selling',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
