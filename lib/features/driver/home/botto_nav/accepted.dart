import 'dart:developer';

import 'package:dairyheart/features/auth/login/presentation/page/login.dart';
import 'package:dairyheart/features/driver/home/controller/driver_controller.dart';
import 'package:dairyheart/features/driver/map/gmap.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AcceptedPage extends StatelessWidget {
  const AcceptedPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                        Get.offAll(const LoginPage());
                      },
                      child: const Icon(Icons.logout),
                    )
                  ],
                ),
              ),
            ),
            Expanded(child: GetBuilder<DriverController>(
              builder: (controller) {
                controller.addacceptcordenate();
                controller.addAcceptedRetailData();
                log(controller.acceptedvalues.length.toString());
                return controller.acceptedvalues.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: controller.acceptedvalues.length,
                        itemBuilder: (context, index) {
                          log(controller.accpetRetailData.toString(),
                              name: 'ui');
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 212, 212, 212),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: Image.network(
                                            controller.dataList[0][
                                                controller.acceptedvalues[index]
                                                    ['pname']]['pic'],
                                          )

                                          /// 'https://assets-global.website-files.com/5e9ebc3fff165933f19fbdbe/61b31c9d289e22335b6753b2_Ice%20Cream%202.jpg'),
                                          ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Shop: ${controller.accpetRetailData[index]['shopName']}'),
                                          Text(
                                              'place: ${controller.accpetRetailData[index]['place']}'),
                                          Text(
                                              'ph: ${controller.accpetRetailData[index]['number']}'),
                                          GestureDetector(
                                            onTap: () => Get.to(NavigationScreen(
                                                controller
                                                    .accpetcordination[index]
                                                    .latitude,
                                                controller
                                                    .accpetcordination[index]
                                                    .longitude)),
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
                                          ),
                                          Text(
                                            'Driver Id: ${controller.acceptedvalues[index]['driverid']}',
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.015),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.deleverstatusUpdate(
                                            controller.accpetRetailData[index]
                                                ['email'],
                                            FirebaseAuth
                                                .instance.currentUser!.email!,
                                            controller.acceptedvalues[index]
                                                ['pname'],
                                            'de',
                                            controller.accepteddKeys[index],
                                            controller.acceptedvalues[index]
                                                ['accdate']);
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.success,
                                          title: 'deleverd',
                                          text: 'Order deleverd',
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.17,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: const Color.fromARGB(
                                              208, 4, 157, 9),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Deleverd',
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
          ])),
    );
  }
}
