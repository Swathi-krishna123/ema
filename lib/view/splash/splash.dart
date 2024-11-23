import 'package:ema/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Get.offNamed('/login');
    });
    return Scaffold(
      body: Center(
          child: SvgPicture.asset(
        'assets/svg/EMA logo.svg',
        height: 50,
        width: 50,
        color: AppColors.white,
      ),),
    );
  }
}
