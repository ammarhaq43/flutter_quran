import 'package:flutter/material.dart';
import 'package:flutter_quran/ui/register_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../ui/login_screen.dart';
import '../ui/main_screen.dart';
import '../ui/splash_screen.dart';


// I'm using Getx for state management

List<GetPage<dynamic>> getPages() {
  return [
    GetPage(name: "/", page: ()=>  SplashScreen()),
    GetPage(name: "/login_screen", page: ()=>  LoginScreen()),
    GetPage(name: "/register_screen", page: ()=>  RegistrationScreen()),
    GetPage(name: "/main_screen", page: ()=>  MainScreen()),
  ];
}