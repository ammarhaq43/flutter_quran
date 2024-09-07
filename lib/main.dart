import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quran/ui/juz_screen.dart';
import 'package:flutter_quran/ui/login_screen.dart';
import 'package:flutter_quran/ui/register_screen.dart';
import 'package:flutter_quran/ui/splash_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_quran/ui/main_screen.dart';
import 'package:flutter_quran/ui/onboarding_screen.dart';
import 'package:flutter_quran/ui/surah_detail.dart';
import 'constants/constants.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muslim Soul',
      theme: ThemeData(
        primarySwatch: Constants.kSwatchColor,
        primaryColor: Constants.kPrimary,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/main': (context) => MainScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        JuzScreen.id: (context) => const JuzScreen(),
        Surahdetail.id: (context) => const Surahdetail()
      },
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegistrationScreen()),
        GetPage(name: '/main', page: () => MainScreen()),
      ],
        );
  }
}
