import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoru/ui/register/register_page.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Transform.translate(
              offset: const Offset(0, 10),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/image/LOGO.png",
                      width: Get.width / 10,
                    ),
                    Text(
                      "MentorU",
                      style: TextStyle(color: Colors.black, fontSize: Get.width / 20),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(minWidth: Get.width),
              height: Get.width,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/image/Mask group.png"))),
            ),
            Transform.translate(
                offset: const Offset(0, -50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Hadi\nBaşlayalım!",
                    style: TextStyle(
                      fontSize: Get.width / 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    width: Get.width,
                    height: Get.width / 8,
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(
                      "Kayıt ol",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: Get.width / 25),
                    )),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
