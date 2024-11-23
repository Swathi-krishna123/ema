import 'package:ema/constants/colors.dart';
import 'package:ema/constants/customWidgets.dart';
import 'package:ema/view/instructionPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class Exercises extends StatelessWidget {
  const Exercises({super.key});

  @override
  Widget build(BuildContext context) {
    // List of video file paths (from assets)
    final List<String> videoPaths = [
      'assets/videos/videoplayback.mp4',
      'assets/videos/videoplayback.mp4',
      'assets/videos/videoplayback.mp4',
      'assets/videos/videoplayback.mp4',
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        leadingWidth: 150,
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                  size: 18,
                )),
            Text(
              'Exercises',
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: videoPaths.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: GestureDetector(
                                onTap: () => Get.to(InstructionPage(
                                    videoUrl: videoPaths[index])),
                                child: VideoPlayerWidget(
                                    videoUrl: videoPaths[index]),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, bottom: 30, top: 15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.blue1,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Seated Jacks',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Reps done: ',
                                      style: TextStyle(
                                          color:
                                              AppColors.white.withOpacity(0.7),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '0 / 3',
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Status:  ',
                                      style: TextStyle(
                                          color:
                                              AppColors.white.withOpacity(0.7),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Text(
                                      'Incomplete',
                                      style: TextStyle(
                                          color: Color(0xffFF6E6E),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Customwidgets().container(
                buttonName: 'Perform incomplete exercises',
                containerColor: AppColors.white,
                textColor: AppColors.black1,
                height: 45,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the video player controller with the asset video
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // Refresh the UI once the video is ready
      });
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Dispose the controller when the widget is destroyed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
