import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quran/ui/juz_screen.dart';
import 'package:flutter_quran/ui/login_screen.dart';
import 'package:flutter_quran/ui/main_screen.dart';
import 'package:flutter_quran/ui/onboarding_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _controller = Get.put(SplashController());
  bool alreadyUsed = false;

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      alreadyUsed = prefs.getBool("alreadyUsed") ?? false;
    });
  }
  
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getData();
    Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Text(
                'Muslim Soul',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset('assets/islamic.png'),
            ),
          ],
        ),
      ),
    );
  }
}
