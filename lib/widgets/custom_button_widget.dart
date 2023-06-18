import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final bool isBorder;
  final bool isFilled;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.child,
    required this.isBorder,
    required this.isFilled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
                color: isFilled ? Colors.black : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: isBorder ? Colors.grey : Colors.transparent)),
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: child),
          )),
    );
  }
}
