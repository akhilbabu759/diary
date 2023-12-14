import 'package:get/get.dart';

class AuthCont extends GetxController{
  bool usercheck=false;
  userchange(bool val){
    usercheck=val;
    update();
  }
}