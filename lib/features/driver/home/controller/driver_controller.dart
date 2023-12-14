import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';

class DriverController extends GetxController {
  @override
  void onInit() {
    fetchOrderData();
    retailFetch();
    productfetch();

    super.onInit();
    addAcceptedRetailData();
  }

  Map<String, dynamic>? classData = {};
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];
  List<Map<String, dynamic>> retailac = [];
  List<Map<String, dynamic>> acceptedvalues = [];
  List<String> accepteddKeys = [];
  List<Map<String, dynamic>> deleverdvalues = [];
  List<String> deleverdKeys = [];

  Map<String, dynamic> data = {};
  List<Map<String, dynamic>> placedvalues = [];
  List<String> PlacedKeys = [];
  List<Map<String, dynamic>> placeRetailData = [];
  List<Map<String, dynamic>> accpetRetailData = [];
  List<Map<String, dynamic>> delevrRetailData = [];
  List<Location> placecordination = [];
  List<Location> accpetcordination = [];
  List<Location> delevrcordination = [];

  Future<Location?> getLocationCoordinates(String placeName) async {
    log('called1');
    try {
      List<Location> locations = await locationFromAddress(placeName);
      log('called2');
      if (locations.isNotEmpty) {
        log('called3');
        Location location = locations.first;
        return locations.first;
      } else {
        log('called4');
        if (kDebugMode) {
          print('Location not found');
        }
        return Location(
            latitude: 23.0525, longitude: 72.5667, timestamp: DateTime.now());
      }
    } catch (e) {
      log('called5');
      log(e.toString());
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  void productfetch() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore.collection('diariproducts').get();

      if (querySnapshot.docs.isNotEmpty) {
        dataList = querySnapshot.docs.map((doc) => doc.data()).toList();
        update();
        log(dataList[0].toString(), name: 'jjj');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }

  void retailFetch() async {
    try {
      QuerySnapshot orderSnapshot =
          await FirebaseFirestore.instance.collection('retailAcc').get();

      if (orderSnapshot.docs.isNotEmpty) {
        for (var document in orderSnapshot.docs) {
          // Access each document's data
          retailac.add(document.data() as Map<String, dynamic>);
          log('Order data: $retailac', name: 'jnxkjsnak');
        }
      } else {
        if (kDebugMode) {
          print('No orders found');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching orders: $e');
      }
    }
  }

  void fetchOrderData() async {
    PlacedKeys.clear();
    placedvalues.clear();
    accepteddKeys.clear();
    acceptedvalues.clear();
    deleverdvalues.clear();
    deleverdKeys.clear();
    try {
      QuerySnapshot orderSnapshot =
          await FirebaseFirestore.instance.collection('order').get();

      if (orderSnapshot.docs.isNotEmpty) {
        for (var document in orderSnapshot.docs) {
          // Access each document's data
          data = document.data() as Map<String, dynamic>;
          log('Order data: $data', name: 'jnxkjsnak');
          //log(data.values.toList()[0]['status'].toString());
          int j = 0;
          for (Map i in data.values.toList()) {
            if (i['status'] == 'pl') {
              placedvalues.add(i as Map<String, dynamic>);
              PlacedKeys.add(data.keys.toList()[j]);
              // addPlacedRetailData(i);
            }
            if (i['status'] == 'ac') {
              acceptedvalues.add(i as Map<String, dynamic>);
              accepteddKeys.add(data.keys.toList()[j]);
              // addPlacedRetailData(i);
            }
            if (i['status'] == 'de') {
              deleverdvalues.add(i as Map<String, dynamic>);
              deleverdKeys.add(data.keys.toList()[j]);
              // addPlacedRetailData(i);
            }

            log(i['status']);
            log(data.keys.toList()[j]);
            j++;
          }
          log(placeRetailData.toString(), name: 'kop');

          // You can access specific fields using data['fieldName']
          update();
        }
        update();
      } else {
        if (kDebugMode) {
          print('No orders found');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching orders: $e');
      }
    }
  }

  void addPlacedRetailData() async {
    placeRetailData.clear();
    placecordination.clear();
    log('moye oye 2');
    log(retailac.toString(), name: 'erij');
    for (Map<String, dynamic> i in placedvalues) {
      log(i.toString());
      for (Map<String, dynamic> j in retailac) {
        if (i['retailid'] == (j['email'])) {
          log('moye oye');

          placeRetailData.add(j);
          // Location v =
          //     await getLocationCoordinates(j['place']).then((value) => value!);
          // log(v.toString());
          // placecordination.add(v);
        }
      }
    }

    log(placeRetailData.toString(), name: 'koppl');
  }
  void addPlacedcordenate() async {
   
    placecordination.clear();
    log('moye oye 2');
    log(retailac.toString(), name: 'erij');
    for (Map<String, dynamic> i in placedvalues) {
      log(i.toString());
      for (Map<String, dynamic> j in retailac) {
        if (i['retailid'] == (j['email'])) {
          log('moye oye');

         log(j['place']);
          Location v =
              await getLocationCoordinates(j['place']).then((value) => value!);
          log(v.toString());
          placecordination.add(v);
        }
      }
    }

    log(placecordination.length.toString(), name: 'koppl');
  }
   void addacceptcordenate() async {
   
    placecordination.clear();
    log('moye oye 2');
    log(retailac.toString(), name: 'erij');
    for (Map<String, dynamic> i in acceptedvalues) {
      log(i.toString());
      for (Map<String, dynamic> j in retailac) {
        if (i['retailid'] == (j['email'])) {
          log('moye oye');

         log(j['place']);
          Location v =
              await getLocationCoordinates(j['place']).then((value) => value!);
          log(v.toString());
          accpetcordination.add(v);
        }
      }
    }

    log(placecordination.length.toString(), name: 'koppl');
  }
   void adddelevercordenate() async {
   
    placecordination.clear();
    log('moye oye 2');
    log(retailac.toString(), name: 'erij');
    for (Map<String, dynamic> i in deleverdvalues) {
      log(i.toString());
      for (Map<String, dynamic> j in retailac) {
        if (i['retailid'] == (j['email'])) {
          log('moye oye');

         log(j['place']);
          Location v =
              await getLocationCoordinates(j['place']).then((value) => value!);
          log(v.toString());
          delevrcordination.add(v);
        }
      }
    }

    log(placecordination.length.toString(), name: 'koppl');
  }

  void addAcceptedRetailData()async {
    int n=0;
    accpetRetailData.clear();
    accpetcordination.clear();
    log('moye oye 2');
    log(acceptedvalues.toString(), name: 'erijacc');
    log('message');
    for (Map<String, dynamic> i in acceptedvalues) {
      log(i.toString());
      for (Map<String, dynamic> j in retailac) {
        if (i['retailid'] == (j['email'])) {
          log('moye oye acce$n');
          log(j.toString());
          n=n+1;

          accpetRetailData.add(j);
          log(accpetRetailData.toString(),name: 'accechec');
          
          
        }
      }
    }

    log(accpetRetailData.toString(), name: 'kopac');
  }

  void adddeleverdRetailData() async {
    delevrRetailData.clear();
    delevrcordination.clear();
    log('moye oye 2');
    log(deleverdvalues.toString(), name: 'erijdel');
    for (Map<String, dynamic> i in deleverdvalues) {
      log(i.toString());
      for (Map<String, dynamic> j in retailac) {
        if (i['retailid'] == (j['email'])) {
          log('moye oye');

          delevrRetailData.add(j);
          
        }
      }
    }

    log(delevrRetailData.toString(), name: 'kopdel');
  }

  void statusUpdate(String email, String driverid, String pname, String status,
      String key) async {
    try {
      final DocumentReference orderDocument =
          FirebaseFirestore.instance.collection('order').doc(email);
      log(orderDocument.get().toString());
      log(key);
      String formattedDate1 =
          DateFormat('yyyy-MM-dd – HH:mm:ss').format(DateTime.now());

      final data = {
        'driverid': driverid,
        'pname': pname,
        'retailid': email,
        'status': status,
        'accdate': formattedDate1
      };

      await orderDocument.update({key.toString(): data});
      fetchOrderData();
    } catch (e) {
      log(e.toString());
    }
  }

  void deleverstatusUpdate(String email, String driverid, String pname,
      String status, String key, String date) async {
    try {
      final DocumentReference orderDocument =
          FirebaseFirestore.instance.collection('order').doc(email);
      log(orderDocument.get().toString());
      log(key);
      String formattedDate1 =
          DateFormat('yyyy-MM-dd – HH:mm:ss').format(DateTime.now());

      final data = {
        'driverid': driverid,
        'pname': pname,
        'retailid': email,
        'status': status,
        'accdate': date,
        'delevery': formattedDate1
      };

      await orderDocument.update({key.toString(): data});
      fetchOrderData();
    } catch (e) {
      log(e.toString());
    }
  }
}
