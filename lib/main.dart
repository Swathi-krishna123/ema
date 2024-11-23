import 'package:ema/constants/colors.dart';
import 'package:ema/view/authentication/forgotPassword.dart';
import 'package:ema/view/authentication/login.dart';
import 'package:ema/view/authentication/signUp.dart';
import 'package:ema/view/exercises.dart';
import 'package:ema/view/homeScreen/homePage.dart';
import 'package:ema/view/instructionPage.dart';
import 'package:ema/view/nextinPage.dart';
import 'package:ema/view/rewardPage.dart';
import 'package:ema/view/splash/splash.dart';
import 'package:ema/view/videoRecord.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.themeColor,
          textTheme: GoogleFonts.interTextTheme(),
          appBarTheme: AppBarTheme(backgroundColor: AppColors.themeColor)),
      title: 'EMA',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Splash()),
        GetPage(name: '/login', page: () =>  Login()),
        GetPage(name: '/forgotPassword', page: () =>  ForgotPassword()),
        GetPage(name: '/signUp', page: () =>  Signup()),
        GetPage(name: '/homePage', page: () =>  const Homepage()),
        GetPage(name: '/exercises', page: () =>  const Exercises()),
        GetPage(name: '/InstructionPage', page: () =>   InstructionPage()),
        GetPage(name: '/InstructionPage', page: () =>   InstructionPage()),
        GetPage(name: '/VideoRecordPage', page: () =>   VideoRecordPage()),
        GetPage(name: '/Rewardpage', page: () =>   RewardPage()),
        GetPage(name: '/Nextinpage', page: () =>   Nextinpage()),
      ],
    );
  }
}
