import 'package:ema/constants/colors.dart';
import 'package:ema/constants/customWidgets.dart';
import 'package:ema/view/exercises.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerPage({super.key, required this.videoUrl});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  bool isPlaying = false;
  double progress = 0.0;
  Duration? videoDuration;
  bool showControls = false;
  Timer? _hideControlsTimer; // Initialize as nullable

  @override
  void initState() {
    super.initState();

    // Lock orientation to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    // Initialize the video player controller
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          videoDuration =
              _controller.value.duration; // Assign only after initialization
        });

        // Start playing the video immediately after initialization
        _controller.play();
        isPlaying = true;
      }).catchError((e) {
        // Handle initialization failure
        setState(() {
          videoDuration =
              Duration.zero; // Assign a default duration in case of error
        });
      })
      ..addListener(() {
        if (_controller.value.isInitialized && mounted) {
          setState(() {
            progress = _controller.value.position.inMilliseconds.toDouble();
          });
        }
      });
  }

  @override
  void dispose() {
    // Reset orientation and dispose of the controller
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller.dispose();
    _hideControlsTimer?.cancel(); // Cancel the timer when disposing
    super.dispose();
  }

  // Toggle play/pause
  void togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        isPlaying = false;
      } else {
        _controller.play();
        isPlaying = true;
      }
    });
    _resetControlsTimer();
  }

  // Seek to a specific position in the video
  void seekTo(double value) {
    final position = Duration(milliseconds: value.toInt());
    _controller.seekTo(position);
    _resetControlsTimer();
  }

  // Rewind the video by 10 seconds
  void rewind() {
    final position = _controller.value.position - const Duration(seconds: 10);
    _controller.seekTo(position);
    _resetControlsTimer();
  }

  // Forward the video by 10 seconds
  void forward() {
    final position = _controller.value.position + const Duration(seconds: 10);
    _controller.seekTo(position);
    _resetControlsTimer();
  }

  // Reset the timer to hide controls
  void _resetControlsTimer() {
    if (_hideControlsTimer?.isActive ?? false) {
      _hideControlsTimer?.cancel();
    }
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        showControls = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if we are in the last minute of the video
    bool isInLastMinute =
        (videoDuration ?? Duration.zero).inMilliseconds != 0 &&
            _controller.value.position >=
                (videoDuration! - const Duration(minutes: 1));

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            showControls = !showControls; // Toggle visibility of controls
          });
          _resetControlsTimer(); // Restart the timer on tap
          togglePlayPause();
        },
        child: Center(
          child: _controller.value.isInitialized
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    // Video Player
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    // Controls (Visible when showControls is true)
                    Visibility(
                      visible: showControls,
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Backward Button (Rewind 10 seconds)
                            CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  AppColors.black1.withOpacity(0.58),
                              child: IconButton(
                                icon: Icon(
                                  Icons.replay_10,
                                  size: 35,
                                  color: AppColors.white,
                                ),
                                onPressed: rewind,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            // Play/Pause Button
                            CircleAvatar(
                              radius: 30,
                              backgroundColor:
                                  AppColors.black1.withOpacity(0.58),
                              child: IconButton(
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  size: 45,
                                  color: AppColors.white,
                                ),
                                onPressed: togglePlayPause,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            // Forward Button (Forward 10 seconds)
                            CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  AppColors.black1.withOpacity(0.58),
                              child: IconButton(
                                icon: Icon(
                                  Icons.forward_10,
                                  size: 35,
                                  color: AppColors.white,
                                ),
                                onPressed: forward,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Full-width Progress Bar (Seek Bar)
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Slider(
                        value: progress,
                        min: 0.0,
                        max: videoDuration!.inMilliseconds.toDouble(),
                        onChanged: seekTo,
                        activeColor: AppColors.themeColor,
                        inactiveColor: AppColors.white.withOpacity(0.4),
                      ),
                    ),
                    // Overlay for the last minute
                    if (isInLastMinute)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black
                              .withOpacity(0.5), // Semi-transparent overlay
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Rewardpage
                                  // VideoRecordPage

                                  Get.toNamed('/VideoRecordPage');

                                  _controller.pause();
                                },
                                child: Customwidgets().container(
                                    buttonName: 'Start excercise',
                                    containerColor: AppColors.white,
                                    height: 53,
                                    width: 259,
                                    textColor: AppColors.black1),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () => Get.off(const Exercises()),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Get.off(const Exercises());
                                        },
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: AppColors.white,
                                        )),
                                    Text(
                                      'Go back',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.white),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
