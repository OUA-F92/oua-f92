import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleTextWidget extends StatelessWidget {
  final title;
  const TitleTextWidget({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      style: TextStyle(fontSize: Get.width / 24, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
    );
  }
}
