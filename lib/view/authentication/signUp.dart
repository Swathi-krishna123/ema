import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/customWidgets.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // TextEditingController inviteCodeController = TextEditingController();
  TextEditingController nhsnumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool isPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;
  final FocusNode nhsNumberFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmpasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
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
                Text(
                  'Sign Up',
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Enter your invite code, NHS Number and create a new password to accept the invite',
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Text(
                //   'Invite Code',
                //   style: TextStyle(
                //     color: AppColors.white.withOpacity(0.7),
                //     fontWeight: FontWeight.w400,
                //     fontSize: 14,
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // Customwidgets().textFormField(
                //     hintText: '0126700975', controller: inviteCodeController),
                // const SizedBox(
                //   height: 15,
                // ),
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
                    controller: nhsnumberController,
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
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      onFieldSubmitted: (value) => FocusScope.of(context)
                          .requestFocus(confirmpasswordFocusNode),
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required field';
                        }
                      },
                      obsecuretext: isPasswordVisible.value,
                      suffixIcon: IconButton(
                          onPressed: () {
                            isPasswordVisible.value = !isPasswordVisible.value;
                          },
                          icon: isPasswordVisible.value
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
                  height: 15,
                ),
                Text(
                  'Confirm Password',
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
                      hintText: 'Confirm password here ...',
                      controller: confirmPasswordController,
                      focusNode: confirmpasswordFocusNode,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required field';
                        }
                        if (value != confirmPasswordController) {
                          return ' password do not match';
                        }
                      },
                      obsecuretext: isConfirmPasswordVisible.value,
                      suffixIcon: IconButton(
                          onPressed: () {
                            isConfirmPasswordVisible.value =
                                !isConfirmPasswordVisible.value;
                          },
                          icon: isConfirmPasswordVisible.value
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
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      Get.offNamed('/login');
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
                GestureDetector(
                  onTap: () => Get.toNamed('/login'),
                  child: Customwidgets().container(
                      buttonName: 'Go Back',
                      height: 45,
                      width: double.infinity,
                      containerColor: AppColors.blue,
                      textColor: AppColors.white),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
