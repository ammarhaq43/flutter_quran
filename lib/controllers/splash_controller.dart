import 'dart:async';

import 'package:get/get.dart';

class SplashController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Timer(Duration(seconds: 3), (){
      Get.offNamed('/login_screen');

    });
  }
}