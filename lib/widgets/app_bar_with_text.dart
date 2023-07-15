import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'title_text_widget.dart';

class AppBarWithText extends StatefulWidget {
  const AppBarWithText({
    super.key,
  });

  @override
  State<AppBarWithText> createState() => _AppBarWithTextState();
}

class _AppBarWithTextState extends State<AppBarWithText> {
  TextEditingController textController = TextEditingController();
  bool isSearchBar = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          print("filter");
        },
        child: Image.asset(
          "assets/icons/filter.png",
          width: Get.width * 0.08,
          height: Get.width * 0.08,
        ),
      ),
      title: const TitleTextWidget(
        title: "Keşfet",
      ),
    );
  }
}
