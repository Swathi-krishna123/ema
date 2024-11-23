import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRequestPage extends StatelessWidget {
  Future<void> requestPermissions(BuildContext context) async {
    // Request camera and microphone permissions
    var cameraStatus = await Permission.camera.request();
    var microphoneStatus = await Permission.microphone.request();

    // Check permissions
    if (cameraStatus.isGranted && microphoneStatus.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permissions granted!')),
      );
    } else if (cameraStatus.isDenied || microphoneStatus.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permissions denied. Please allow permissions.')),
      );
    } else if (cameraStatus.isPermanentlyDenied || microphoneStatus.isPermanentlyDenied) {
      // Open app settings if permissions are permanently denied
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permissions permanently denied. Please enable them in settings.')),
      );
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Permissions'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => requestPermissions(context),
          child: Text('Request Camera & Microphone Permissions'),
        ),
      ),
    );
  }
}
