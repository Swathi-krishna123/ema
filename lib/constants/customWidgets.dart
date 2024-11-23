import 'package:flutter/material.dart';

import 'colors.dart';

class Customwidgets {
  TextFormField textFormField({
    String? hintText,
    TextEditingController? controller,
    IconButton? suffixIcon,
    bool obsecuretext = false,
    Function? validation,
    FocusNode? focusNode,
    Function(String)? onFieldSubmitted,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obsecuretext,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      validator: validation as String? Function(String?)?,
      style: TextStyle(color: AppColors.white, fontSize: 14),
      cursorColor: AppColors.white,
      decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.blue,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.white),
          suffixIcon: suffixIcon),
    );
  }

  Container container(
      {String? buttonName,
      Color? containerColor,
      Color? textColor,
      double? height,
      double? width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: containerColor),
      child: Center(
        child: Text(
          buttonName!,
          style: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
