import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

// ignore: camel_case_types
class appbar_with_name extends StatefulWidget {
  const appbar_with_name({
    super.key,
  });

  @override
  State<appbar_with_name> createState() => _appbar_with_nameState();
}

class _appbar_with_nameState extends State<appbar_with_name> {
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
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
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
                      userData["username"],
                      style: TextStyle(fontSize: Get.width / 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                CircleAvatar(
                  radius: Get.width / 15,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(userData["image"]),
                )
              ],
            ),
          );
  }
}
