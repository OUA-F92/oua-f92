import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user.dart';

class PopularCardListWidget extends StatefulWidget {
  const PopularCardListWidget({
    super.key,
  });

  @override
  State<PopularCardListWidget> createState() => _PopularCardListWidgetState();
}

class _PopularCardListWidgetState extends State<PopularCardListWidget> {
  List<User> profileInformations = [
    User(
        age: [],
        occupation: ["Software Engineer"],
        location: ["Meta"],
        email: "email",
        bio: [],
        image: ["assets/image/profile (2).png"],
        star: [],
        uid: "",
        username: "Name Surname"),
    User(
        age: [],
        occupation: ["Software Engineer"],
        location: ["Meta"],
        email: "email",
        bio: [],
        image: ["assets/image/profile (3).png"],
        star: [],
        uid: "",
        username: "Name Surname"),
    User(
        age: [],
        occupation: ["Software Engineer"],
        location: ["Meta"],
        email: "email",
        bio: [],
        image: ["assets/image/profile (4).png"],
        star: [],
        uid: "",
        username: "Name Surname"),
    User(
        age: [],
        occupation: ["Software Engineer"],
        location: ["Meta"],
        email: "email",
        bio: [],
        image: ["assets/image/profile (2).png"],
        star: [],
        uid: "",
        username: "Name Surname"),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width / 1.8,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: profileInformations.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                // ignore: avoid_print
                print("popular card list $index");
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Get.width * 0.05),
                        image: DecorationImage(image: AssetImage(profileInformations[index].image.first), fit: BoxFit.cover)),
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
                          child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.end, children: [
                            Text(
                              profileInformations[index].username,
                              maxLines: 2,
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
                              profileInformations[index].occupation.first,
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
  }
}
