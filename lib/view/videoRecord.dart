import 'dart:async';
import 'dart:io'; // For File operations
import 'package:camera/camera.dart';
import 'package:ema/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart'; // For getting file storage location

class VideoRecordPage extends StatefulWidget {
  @override
  _VideoRecordPageState createState() => _VideoRecordPageState();
}

class _VideoRecordPageState extends State<VideoRecordPage> {
  CameraController? _cameraController;
  late List<CameraDescription> cameras;
  bool isRecording = false; // Track if recording is active
  bool isPaused = false; // Track if recording is paused
  Duration elapsedTime = Duration.zero;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    initializeFrontCamera();
  }

  Future<void> initializeFrontCamera() async {
    try {
      cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => throw Exception("No front camera found"),
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      setState(() {});
    } catch (e) {
      print('Camera initialization error: $e');
    }
  }

  void toggleRecording() {
    setState(() {
      if (!isRecording) {
        // Start recording
        isRecording = true;
        isPaused = false;
        startTimer();
        startVideoRecording();
      } else if (!isPaused) {
        // Pause recording
        isPaused = true;
        stopTimer();
      } else {
        // Resume recording
        isPaused = false;
        startTimer();
      }
    });
  }

  // Start recording and store the video in a temporary location
  Future<void> startVideoRecording() async {
    try {
      final directory = await getTemporaryDirectory(); // Get the temp directory
      final videoPath = '${directory.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4'; // Create a unique file name
      await _cameraController?.startVideoRecording();
      print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++Recording started at: $videoPath'); // Logging the video path
    } catch (e) {
      print('Error starting video recording: $e');
    }
  }

  // Stop recording and save the video file
  void stopRecording() async {
    try {
      final file = await _cameraController?.stopVideoRecording();
      print('=============================================================Recording stopped, saved at: ${file?.path}'); // Log the path of the saved video file
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${file?.path}')));
      Get.toNamed('/Rewardpage');
      setState(() {
        isRecording = false;
        isPaused = false;
        stopTimer();
        elapsedTime = Duration.zero; // Reset the timer
      });
      
      // You can also move the file to a more permanent location if needed, 
      // or use it to display, share, or save further as required.
      
    } catch (e) {
      print('Error stopping video recording: $e');
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        elapsedTime = Duration(seconds: elapsedTime.inSeconds + 1);
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    // Lock the orientation to portrait when this page is displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    });

    return WillPopScope(
        onWillPop: () async {
          // Reset to default orientation on back navigation
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
          return true; // Allow back navigation
        },
        child: Scaffold(
          body: Stack(
            children: [
              // Camera Preview
              if (_cameraController?.value.isInitialized ?? false)
                CameraPreview(_cameraController!),
              if (!(_cameraController?.value.isInitialized ?? false))
                const Center(child: CircularProgressIndicator()),
              // Timer Display
              if (isRecording)
                Positioned(
                  top: 50,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      formatDuration(elapsedTime),
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Conditionally Show Stop Button
                      if (isRecording)
                        GestureDetector(
                          onTap: stopRecording,
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.stop,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ),
                      if (isRecording) const SizedBox(width: 30),
                      // Recording Indicator with Play/Pause Toggle
                      GestureDetector(
                        onTap: toggleRecording,
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.white,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: const BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  !isRecording
                                      ? null
                                      : isPaused
                                          ? Icons.play_arrow
                                          : Icons.pause,
                                  color: AppColors.white,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    timer?.cancel();
    super.dispose();
  }
}
