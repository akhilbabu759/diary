import 'dart:developer';

import 'package:dairyheart/features/auth/login/presentation/page/login.dart';
import 'package:dairyheart/features/driver/home/controller/driver_controller.dart';
import 'package:dairyheart/features/driver/map/gmap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class DriverHome extends StatelessWidget {
  const DriverHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DriverController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu),
                  const Center(child: Text('Driver')),
                  GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                        buttonColor: (Colors.blue),
                        title: 'Log out',
                        content: Text('Are you sure?'),
                        textConfirm: 'yes',
                        textCancel: 'No',
                        // cancelTextColor: Colors.white,
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          // Do something when the user confirms
                          Get.offAll(const LoginPage()); // Close the dialog
                        },
                        onCancel: () => Get.back(),
                      );
                      ;
                    },
                    child: const Icon(Icons.logout),
                  )
                ],
              ),
            ),
          ),
          Expanded(child: GetBuilder<DriverController>(
            builder: (controller) {
              controller.addPlacedcordenate();
              return controller.placedvalues.isEmpty 
                  ? Text('')
                  : ListView.builder(
                      itemCount: controller.placedvalues.length,
                      itemBuilder: (context, index) {
                        controller.addPlacedRetailData();

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 212, 212, 212),
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 18.0,
                                  bottom: 15,
                                  left:
                                      MediaQuery.of(context).size.width * 0.02,
                                  right:
                                      MediaQuery.of(context).size.width * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.27,
                                        child: Image.network(
                                          controller.dataList[0][
                                              controller.placedvalues[index]
                                                  ['pname']]['pic'],
                                          fit: BoxFit.cover,width:MediaQuery.of(context).size.width *
                                                0.1 ,
                                        )

                                        /// 'https://assets-global.website-files.com/5e9ebc3fff165933f19fbdbe/61b31c9d289e22335b6753b2_Ice%20Cream%202.jpg'),
                                        ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Shop: ${controller.placeRetailData[index]['shopName']}'),
                                        Text(
                                            'place: ${controller.placeRetailData[index]['place']}'),
                                        Text(
                                            'ph: ${controller.placeRetailData[index]['number']}',style: TextStyle(fontSize: Get.width*0.033),),
                                        GestureDetector(
                                          onTap: () {
                                            log(controller
                                                .placecordination[index]
                                                .toString());

                                            Get.to(NavigationScreen(
                                                controller
                                                    .placecordination[index]
                                                    .latitude,
                                                controller
                                                    .placecordination[index]
                                                    .longitude));
                                          },
                                          child: const Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_sharp,
                                                color: Color.fromARGB(
                                                    239, 68, 137, 255),
                                              ),
                                              Text(
                                                'To Navigate',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 72, 108, 126)),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.statusUpdate(
                                          controller.placeRetailData[index]
                                              ['email'],
                                          FirebaseAuth
                                              .instance.currentUser!.email!,
                                          controller.placedvalues[index]
                                              ['pname'],
                                          'ac',
                                          controller.PlacedKeys[index]);
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.success,
                                        title: 'Accept',
                                        text: 'Order Accepted',
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.17,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: const Color.fromARGB(
                                            208, 4, 157, 9),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Accept',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
          ))
        ]),
      ),
    );
  }
}
