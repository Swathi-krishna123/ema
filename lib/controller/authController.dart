import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Authcontroller extends GetxController {
  ////////// login //////////////
  final TextEditingController nhsnumberLoginController =
      TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();
  RxBool isLoginPasswordVisible = true.obs;


  Future<bool> login(
      {required String nhsNumber, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));

    if (nhsNumber == "123456789" && password == "123") {
      return true;
    } else {
      return false;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    nhsnumberLoginController.dispose();
    passwordLoginController.dispose();
  }
}
