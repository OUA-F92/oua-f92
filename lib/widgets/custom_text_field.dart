import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController controller;

  CustomTextField(
      {super.key,
      required this.hintText,
      this.suffixIcon,
      this.obscureText = false,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        style: TextStyle(fontWeight: FontWeight.w600),
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            fillColor: Colors.white30,
            border: InputBorder.none,
            filled: true,
            hintText: hintText,
            suffixIcon: suffixIcon,
            hintStyle: TextStyle(
                fontSize: Get.width / 27, fontWeight: FontWeight.w500),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(width: 2, color: Colors.grey.shade400)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(width: 2, color: Colors.grey.shade400))),
      ),
    );
  }
}
