import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class appbar_with_name extends StatelessWidget {
  const appbar_with_name({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hoşgeldin",
                    style: TextStyle(fontSize: Get.width / 24),
                  ),
                  Image.asset(
                    "assets/icons/hands.png",
                  )
                ],
              ),
              Text(
                "Name Surname",
                style: TextStyle(fontSize: Get.width / 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
          CircleAvatar(
            radius: Get.width / 15,
            backgroundColor: Colors.transparent,
            backgroundImage: const AssetImage("assets/icons/account.png"),
          )
        ],
      ),
    );
  }
}
