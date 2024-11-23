import 'package:ema/constants/colors.dart';
import 'package:ema/constants/customWidgets.dart';
import 'package:ema/view/videoPlayerPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class InstructionPage extends StatelessWidget {
  final String? videoUrl; // URL of the video to play

  const InstructionPage({super.key, this.videoUrl});

  @override
  Widget build(BuildContext context) {
    // Lock the orientation to landscape when this page is displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    });

    return WillPopScope(
      onWillPop: () async {
        // Reset to default orientation on back navigation
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return true; // Allow back navigation
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // SvgPicture.asset('assets/svg/imagebg.svg'),
              Lottie.asset('assets/gif/rotatePhone.json',height: 170,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Instruction Message
                      Text(
                        'Tilt your phone at an angle and place \n it against the wall',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Okay Button

                      GestureDetector(
                        onTap: () {
                          Get.off(VideoPlayerPage(videoUrl: videoUrl!));
                        },
                        child: Customwidgets().container(
                            buttonName: 'Okay',
                            height: 53,
                            width: 347,
                            containerColor: AppColors.white,
                            textColor: AppColors.black1),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
