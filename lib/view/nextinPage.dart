import 'package:ema/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Nextinpage extends StatelessWidget {
  final String? videoUrl; // URL of the video to play

  const Nextinpage({super.key, this.videoUrl});

  @override
  Widget build(BuildContext context) {
    // Lock the orientation to landscape when this page is displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    });

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // Reset to default orientation on back navigation
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
        return true; // Allow back navigation
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Great job! you have earned a gold medal!',
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      Text('Upcoming:\nDynamic \nWalk Downs',style: TextStyle(color: AppColors.white,fontWeight: FontWeight.w600,fontSize: 16),)
                    ],),
                    Image.asset('assets/images/Rectangle 9.png'),
                    CircularPercentIndicator(
                      radius: 45,
                      animation: true,
                      animationDuration: 1000,
                      lineWidth: 6,
                      percent: 0.5 / 5,
                      progressColor: const Color(0xffD9D9D9),
                      backgroundColor: AppColors.white.withOpacity(0.2),
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Next in',
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                          Text(
                            '5',
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Text(
                  '',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
