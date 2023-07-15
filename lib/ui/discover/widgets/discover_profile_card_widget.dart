import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoru/ui/discover/widgets/stars_widget.dart';

import '../../../models/user.dart';
import '../../../utils/colors.dart';

class DiscoverProfileCardWidget extends StatefulWidget {
  const DiscoverProfileCardWidget({
    super.key,
  });

  @override
  State<DiscoverProfileCardWidget> createState() => _DiscoverProfileCardWidgetState();
}

class _DiscoverProfileCardWidgetState extends State<DiscoverProfileCardWidget> {
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
      height: Get.width / 2.5,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width / 3.5,
                  height: Get.width / 2.5,
                  decoration: BoxDecoration(
                      color: lightWhiteColor,
                      borderRadius: BorderRadius.circular(Get.width * 0.04),
                      image: DecorationImage(image: AssetImage(profileInformations[index].image.first), fit: BoxFit.cover)),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: Get.width / 3.5,
                  height: Get.width / 2.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        profileInformations[index].username,
                        maxLines: 2,
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.width / 20, overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        height: Get.width * 0.1,
                      ),
                      Text(
                        profileInformations[index].occupation.first,
                        maxLines: 1,
                        style: TextStyle(fontSize: Get.width / 30, fontWeight: FontWeight.w300, overflow: TextOverflow.ellipsis),
                      ),
                      const StarsWidget()
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
