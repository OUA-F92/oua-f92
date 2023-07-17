import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user.dart';
import '../../../widgets/bottom_sheet.dart';

class PopularCardListWidget extends StatefulWidget {
  const PopularCardListWidget({
    super.key,
  });

  @override
  State<PopularCardListWidget> createState() => _PopularCardListWidgetState();
}

class _PopularCardListWidgetState extends State<PopularCardListWidget> {
  // List<User> profileInformations = [
  //   User(
  //       occupation: "Software Engineer",
  //       location: "Meta",
  //       email: "email",
  //       bio: "",
  //       image: "assets/image/profile (2).png",
  //       star: [],
  //       uid: "",
  //       username: "Name Surname"),
  //   User(
  //       occupation: "Software Engineer",
  //       location: "Meta",
  //       email: "email",
  //       bio: "",
  //       image: "assets/image/profile (3).png",
  //       star: [],
  //       uid: "",
  //       username: "Name Surname"),
  //   User(
  //       occupation: "Software Engineer",
  //       location: "Meta",
  //       email: "email",
  //       bio: "",
  //       image: "assets/image/profile (4).png",
  //       star: [],
  //       uid: "",
  //       username: "Name Surname"),
  //   User(
  //       occupation: "Software Engineer",
  //       location: "Meta",
  //       email: "email",
  //       bio: "",
  //       image: "assets/image/profile (2).png",
  //       star: [],
  //       uid: "",
  //       username: "Name Surname"),
  // ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("users").where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SizedBox(
          height: Get.width / 1.8,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              DocumentSnapshot snap = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  onTap: () {
                    // ignore: avoid_print
                    AppointmentBottomSheet(
                      context,
                      snap,
                    );
                    print("popular card list $index");
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Get.width * 0.05),
                            image: DecorationImage(image: NetworkImage(snap["image"]), fit: BoxFit.cover)),
                        width: Get.width / 3,
                        height: Get.width / 1.8,
                      ),
                      Positioned(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Get.width * 0.05),
                          child: Container(
                            width: Get.width / 3,
                            height: Get.width / 1.8,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                end: Alignment.topCenter,
                                begin: Alignment.bottomCenter,
                                colors: <Color>[Colors.black54, Colors.transparent],
                              ),
                            ),
                            child: SizedBox(
                              height: Get.width / 3.6,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      snap["username"],
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: Get.width / 20,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snap["occupation"],
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Get.width / 40,
                                          fontWeight: FontWeight.w300,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
