import 'dart:developer';

import 'package:dairyheart/features/retail/home/controller/home_controller.dart';
import 'package:dairyheart/features/retail/home/widget/order_hist_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHist extends StatelessWidget {
  const OrderHist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('order Histrory'),
        centerTitle: true,
      ),
      body: Column(children: [
        GetBuilder<HomeController>(
          builder: (controller) {
            /// log(controller.dataList[0][controller.classData!.values.toList()[0]['pname']]['pic'],name: 'neallada');
            log(controller.classData!.toString());
            return Expanded(
                child: ListView.builder(
              itemCount: controller.classData!.length,
              itemBuilder: (context, index) => GestureDetector(onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrderHistDetail(
                      date: controller.classData!.keys.toList()[index],
                      details: controller.dataList[0][
                          controller.classData!.values.toList()[index]
                              ['pname']]['details'],
                      pic: controller.dataList[0][controller.classData!.values
                          .toList()[index]['pname']]['pic'],
                      pname: controller.classData!.values.toList()[index]
                          ['pname'],
                      staus: controller.classData!.values.toList()[index]
                          ['status'],
                    ),
                  )),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 4, // Adjust the elevation as needed
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          controller.dataList[0][controller.classData!.values
                              .toList()[index]['pname']]['pic'],
                        ), // Use your image URL here
                      ),
                      title: Text(
                        controller.classData!.values.toList()[index]['pname'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrderHistDetail(
                      date: controller.classData!.keys.toList()[index],
                      details: controller.dataList[0][
                          controller.classData!.values.toList()[index]
                              ['pname']]['details'],
                      pic: controller.dataList[0][controller.classData!.values
                          .toList()[index]['pname']]['pic'],
                      pname: controller.classData!.values.toList()[index]
                          ['pname'],
                      staus: controller.classData!.values.toList()[index]
                          ['status'],
                    ),
                  )),
                    ),
                  ),
                ),
              ),
            ));
          },
        )
      ]),
    );
  }
}
