import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoru/models/user.dart';
import 'package:mentoru/providers/user_provider.dart';
import 'package:mentoru/ui/discover/widgets/stars_widget.dart';
import 'package:mentoru/utils/colors.dart';
import 'package:mentoru/utils/utils.dart';
import 'package:mentoru/widgets/time_slot_widget.dart';
import 'package:mentoru/widgets/title_text_widget.dart';
import 'package:provider/provider.dart';

import '../services/auth_methods.dart';
import 'login/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userData = {};
  var isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).viewPadding.top, horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () async {
                              await AuthMethods().signOut();
                              // ignore: use_build_context_synchronously
                              Get.offAll(LoginPage());
                            },
                            icon: const Icon(Icons.logout_outlined)),
                        TextButton(
                            onPressed: () {
                              print("edit");
                            },
                            child: const Text("Düzenle"))
                      ],
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                          userData['image'],
                        ),
                        radius: Get.width / 6,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: Get.width * 0.05),
                        child: TitleTextWidget(
                          title: userData["username"],
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Yazılım Mühendisi",
                        style: TextStyle(color: darkGrayColor, fontSize: Get.width / 28),
                      ),
                    ),
                    const Center(child: StarsWidget()),
                    const TitleTextWidget(
                      title: "Hakkında",
                    ),
                    Text(
                      userData["bio"],
                      style: TextStyle(color: darkGrayColor),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const TitleTextWidget(
                      title: "E-Posta",
                    ),
                    Text(
                      userData["email"],
                      style: TextStyle(color: darkGrayColor),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TitleTextWidget(
                      title: "Zaman çizelgem",
                    ),
                    TimeSlotWidget(),
                  ],
                ),
              ),
            ),
    );
  }
}
