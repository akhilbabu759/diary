import 'package:dairyheart/features/auth/login/presentation/page/login.dart';
import 'package:dairyheart/features/driver/map/gmap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/driver_controller.dart';

class DeleverdPage extends StatelessWidget {
  const DeleverdPage({super.key});

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
            controller.adddelevercordenate();
            return controller.deleverdvalues.isEmpty
                ? const Center(
                    child: Text('List empty'),
                  )
                : ListView.builder(
                    itemCount: controller.deleverdvalues.length,
                    itemBuilder: (context, index) {
                      controller.adddeleverdRetailData();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 212, 212, 212),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Image.network(
                                        controller.dataList[0][
                                            controller.deleverdvalues[index]
                                                ['pname']]['pic'],
                                      )

                                      /// 'https://assets-global.website-files.com/5e9ebc3fff165933f19fbdbe/61b31c9d289e22335b6753b2_Ice%20Cream%202.jpg'),
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:18.0),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Shop: ${controller.delevrRetailData[index]['shopName']}'),
                                      Text(
                                          'place: ${controller.delevrRetailData[index]['place']}'),
                                      Text(
                                          'ph: ${controller.delevrRetailData[index]['number']}'),
                                      GestureDetector(
                                        onTap: () => Get.to(NavigationScreen(
                                            controller.delevrcordination[index]
                                                .latitude,
                                            controller.delevrcordination[index]
                                                .longitude)),
                                        child: const Row(
                                          children: [
                                            Icon(Icons.location_on_sharp,color: Color.fromARGB(239, 68, 137, 255),),
                                            Text('To Navigate',style: TextStyle(color: Color.fromARGB(255, 72, 108, 126)),)
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'Driver Id: ${controller.deleverdvalues[index]['driverid']}',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
                                      ),
                                    ],
                                  ),
                                ),const Icon(Icons.check_circle,color: Colors.green,size: 32,)
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
    ));
  }
}
