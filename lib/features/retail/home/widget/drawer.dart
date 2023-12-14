import 'package:dairyheart/features/auth/login/presentation/page/login.dart';
import 'package:dairyheart/features/retail/home/widget/order_hist.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class DreawerWidget extends StatelessWidget {
  const DreawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 130, 90, 231),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.11,
                  backgroundImage: const NetworkImage(
                      'https://artriva.com/media/k2/items/cache/c889234799e865bbe90cee71f6cd2e53_XL.jpg'),
                ),
                // Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                //   image: DecorationImage(
                // image: NetworkImage('https://artriva.com/media/k2/items/cache/c889234799e865bbe90cee71f6cd2e53_XL.jpg'), // Replace with your image path
                // fit: BoxFit.cover,
                // colorFilter: ColorFilter.mode(
                //   Colors.black.withOpacity(0.5), // Adjust opacity here
                //   BlendMode.srcOver,
                // )
                // )),
                //   child: Text(
                //     'Akhil',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 24,
                //     ),
                //   ),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Akhil',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                    const Gap(8),
                    Text(
                      'akhilb4001@gmail.com',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 175, 175, 175),
                          fontSize: MediaQuery.of(context).size.width * 0.02),
                    )
                  ],
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              // Implement profile functionality here
              Navigator.pop(context);
              // Add your code to navigate or perform actions related to profile
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Order '),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const OrderHist(),
              ));
              // Add your code to navigate or perform actions related to contact
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Implement settings functionality here
              Navigator.pop(context);
              // Add your code to navigate or perform actions related to settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              // Implement about functionality here
              Navigator.pop(context);
              // Add your code to navigate or perform actions related to about
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_phone),
            title: const Text('Contact'),
            onTap: () {
              // Implement contact functionality here
              Navigator.pop(context);
              // Add your code to navigate or perform actions related to contact
            },
          ),GestureDetector(
            onTap: () {
              Get.offAll(const LoginPage())
              ;
            },child: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}
