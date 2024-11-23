import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/customWidgets.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nhsnumberController = TextEditingController();
  TextEditingController emailaddresController = TextEditingController();
  final FocusNode emailFocusNode =FocusNode();
  final FocusNode nhsNumberFocusNode =FocusNode();

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
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Enter your NHS Number and registered Email address to request a password reset',
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
                    controller: nhsnumberController,
                    focusNode: nhsNumberFocusNode,
                    onFieldSubmitted: (value) =>  FocusScope.of(context).requestFocus(emailFocusNode),
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required field';
                      }
                    }),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Email Address',
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
                    hintText: 'Email address here ...',
                    controller: emailaddresController,
                    focusNode: emailFocusNode,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required field';
                      } 
                      // Email regex pattern
                      String pattern =
                          r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                    }),
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
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Text(
                      'Back to login',
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
