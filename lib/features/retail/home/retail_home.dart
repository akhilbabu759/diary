import 'dart:developer';

import 'package:dairyheart/features/retail/home/controller/home_controller.dart';
import 'package:dairyheart/features/retail/home/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class RetailHome extends StatelessWidget {
  const RetailHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeContro = Get.put(HomeController());

    final List<String> imageList = [
      'https://i.pinimg.com/736x/b5/fb/84/b5fb843522cd96f2f4e4b9832abea75f.jpg',
      'https://freedesignfile.com/upload/2019/05/Natural-farm-milk-food-poster-design-vector-02.jpg',
    ];
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    void _openDrawer(BuildContext context) {
      scaffoldKey.currentState?.openDrawer();
    }

    return Scaffold(
      key: scaffoldKey,
      drawer: const DreawerWidget(),
      backgroundColor: const Color.fromRGBO(143, 148, 251, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(87, 255, 255, 255),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => _openDrawer(context),
                          child: const Icon(Icons.menu)),
                      const Center(
                          child: Text(
                        'Retail',
                        style:
                            TextStyle(color: Color.fromARGB(255, 47, 47, 47)),
                      )),
                      const Text('')
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.9,
                ),
                items: imageList.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              // Wrap the GridView with SizedBox to give it a fixed height
              GetBuilder<HomeController>(
                builder: (controller) {
                  // log(controller.dataList[0]['pic']);

                  return controller.dataList.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.92, // Adjust height as needed
                          child: GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 1 / 1.5,
                            crossAxisCount: 3, // Number of columns
                            children: List.generate(
                                controller.dataList[0].length, (index) {
                              log(controller.dataList[0].values.toList()[0]
                                  ['pic']);

                              return GestureDetector(
                                onTap: () {
                                  Get.defaultDialog(
                                    title: '',
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 150,
                                          width: 200,
                                          child: Card(
                                            elevation: 4.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Image.network(
                                                    controller
                                                        .dataList[0].values
                                                        .toList()[index]['pic'],
                                                    // 'https://assets-global.website-files.com/5e9ebc3fff165933f19fbdbe/61b31c9d289e22335b6753b2_Ice%20Cream%202.jpg',
                                                    height: 142,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          controller.dataList[0].keys
                                              .toList()[index],
                                          style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 125, 125, 125),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Text(
                                            controller.dataList[0].values
                                                .toList()[index]['details'],
                                            // 'Milk is a nutrient-rich liquid food produced by the mammary glands of mammals. It is the primary source of nutrition for infant mammals before they are able to digest other types of food. The early lactation milk is known as colostrum, and carries the mother\'s antibodies to the baby. It contains many other nutrients including protein and lactose. It is a key component in numerous food products like butter, cream, yogurt, and cheese.',
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 100, 100, 100),
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        GestureDetector(
                                          onTap: () {
                                            homeContro.placeOrder(controller
                                                .dataList[0].keys
                                                .toList()[index]);
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.success,
                                              title: 'Placed',
                                              text: 'Order placed',
                                            );
                                          },
                                          child: Container(
                                            width: 120,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: const Color.fromARGB(
                                                  208, 4, 157, 9),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Order',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Image.network(
                                          controller.dataList[0].values
                                              .toList()[index]['pic'],
                                          // 'https://assets-global.website-files.com/5e9ebc3fff165933f19fbdbe/61b31c9d289e22335b6753b2_Ice%20Cream%202.jpg',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.dataList[0].keys
                                                    .toList()[index],
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.015,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 8.0),
                                              Text(
                                                controller.dataList[0].values
                                                    .toList()[index]['details'],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
