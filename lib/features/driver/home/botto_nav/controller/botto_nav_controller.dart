import 'package:get/get.dart';

class BottomNavController extends GetxController{

 int  slecetdindex=0;
 void indexChange( int val){
  slecetdindex=val;
  update();

 }
}