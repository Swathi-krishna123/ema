import 'package:ema/constants/customWidgets.dart';
import 'package:ema/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final FocusNode nhsNumberFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final Authcontroller authcontroller = Get.put(Authcontroller());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        centerTitle: true,
        title: SvgPicture.asset(
          'assets/svg/EMA logo.svg',
          height: 45,
          width: 45,
          color: AppColors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Enter your NHS Number and Password to log into your account',
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'NHS Number',
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Customwidgets().textFormField(
                    hintText: 'NHS number here ..',
                    controller: authcontroller.nhsnumberLoginController,
                    focusNode: nhsNumberFocusNode,
                    onFieldSubmitted: (value) =>
                        FocusScope.of(context).requestFocus(passwordFocusNode),
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required field';
                      }
                    }),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Password',
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Customwidgets().textFormField(
                      hintText: 'Password here ...',
                      controller: authcontroller.passwordLoginController,
                      focusNode: passwordFocusNode,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required field';
                        }
                      },
                      obsecuretext: authcontroller.isLoginPasswordVisible.value,
                      suffixIcon: IconButton(
                          onPressed: () {
                            authcontroller.isLoginPasswordVisible.value =
                                !authcontroller.isLoginPasswordVisible.value;
                          },
                          icon: authcontroller.isLoginPasswordVisible.value
                              ? Icon(
                                  Icons.visibility_off,
                                  color: AppColors.white,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: AppColors.white,
                                ))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Get.toNamed('forgotPassword'),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formkey.currentState!.validate()) {
                      bool loginSuccess = await authcontroller.login(
                        nhsNumber: authcontroller.nhsnumberLoginController.text,
                        password: authcontroller.passwordLoginController.text,
                      );
                      if (loginSuccess) {
                        Get.toNamed('/homePage');
                      } else {
                        Get.snackbar(
                          'Login Failed',
                          'Invalid NHS number or password',
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                        );
                      }
                    }
                  },
                  child: Customwidgets().container(
                      buttonName: 'Continue',
                      height: 45,
                      width: double.infinity,
                      containerColor: AppColors.white,
                      textColor: AppColors.black1),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () => Get.toNamed('/signUp'),
                    child: Text(
                      // 'Have an invite code?',
                      'Register Here',
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
