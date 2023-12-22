import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    fetchData();
    getorderData();

    super.onInit();
  }

   Map<String, dynamic>? classData = {};
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];

  void fetchData() async {
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

  Future<void> getorderData() async {
    log('message');
    try {
      final DocumentReference orDocument = FirebaseFirestore.instance
          .collection('order')
          .doc(FirebaseAuth.instance.currentUser!.email ??
              'akhilb401@gmail.com');

      final DocumentSnapshot orSnapshot = await orDocument.get();
      log('message2');
      log(orSnapshot.data().toString(), name: 'jhfklm');
      if (orSnapshot.exists) {
         classData =
            orSnapshot.data() as Map<String, dynamic>?;
            update();
        log(classData.toString(), name: 'no');
        log('message3');
        if (classData != null) {
         
          // Separate students into class-specific lists
          // final Map<String, List> classStudentMap = {};

          // classData.forEach((className, students) {
          //   if (students is List) {
          //     log('message4');
          //     final List<Student> studentsForClass = [];

          //     for (var studentData in students) {
          //       final Student student = Student.fromJson(studentData as Map<String, dynamic>);
          //       studentsForClass.add(student);
          //     }

          //     classStudentMap[className] = studentsForClass;
          //     log('message5');
          //   }
          // });

          // Store class-specific student lists
          // classStudentMap.forEach((className, students) {
          //   listStudent.addAll(students);
          //   filterKeyList.add(className);
          //   log('message6');
          //   update();
          // Assumes that the first student's status is used

          // classBasedStudent=classStudentMap;
          // update();
          // log(filterStatuslist.toString(),name: '1');
          // log(filterKeyList.toString(),name: '2');
          // log(listStudent.toString(),name: '3');
          // log(classStudentMap.toString(),name: '4');
          // log('message9');

          // classValue = filterKeyList[0];
          // update();
          // filterstatus();
          // log(filterStatuslist.toString(),name: 'njan');
          // update();
        } else {
          log('messageuio');
          // Handle case where 'class' field is missing or empty
        }
      } else {
        log('messagehgjk');
        // Handle case where teacher document does not exist
      }
    } catch (e) {
      log(e.toString(), name: '1900');
      update();
    }
    update();
  }

  void placeOrder(String pname){
    DateTime now = DateTime.now();
      String formattedDate1 = DateFormat('yyyy-MM-dd – HH:mm:ss').format(now);
  
 
    Map<String, dynamic> newData = {
  formattedDate1: {'driverid':'','pname':pname,'status':'pl','retailid':FirebaseAuth.instance.currentUser!.email},
  // Add other fields as needed
};

// Reference to the Firestore document
final DocumentReference teacherDocument = FirebaseFirestore.instance.collection('order').doc(FirebaseAuth.instance.currentUser!.email);

// Add the new data to the document
teacherDocument.set(newData, SetOptions(merge: true))
    .then((_) {
  if (kDebugMode) {
    print("Data added or updated successfully!");
  }
  getorderData();
})
    .catchError((error) {
  if (kDebugMode) {
    print("Error adding/updating data: $error");
  }
});
  }
}
