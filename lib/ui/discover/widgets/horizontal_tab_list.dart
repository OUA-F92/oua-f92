import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoru/ui/discover/widgets/stars_widget.dart';
import 'package:mentoru/widgets/bottom_sheet.dart';
import 'package:mentoru/widgets/custom_text_field.dart';
import 'package:mentoru/widgets/time_slot_widget.dart';
import 'package:mentoru/widgets/title_text_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../utils/colors.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_button_widget.dart';

class HorizontalTabList extends StatefulWidget {
  const HorizontalTabList({super.key});

  @override
  State<HorizontalTabList> createState() => _HorizontalTabListState();
}

class _HorizontalTabListState extends State<HorizontalTabList> with SingleTickerProviderStateMixin {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  late TabController _tabController;
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    getData();

    super.initState();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {} catch (e) {
      print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  final _selectedColor = const Color(0xff1a73e8);
  final _tabs = [
    SizedBox(width: Get.width / 3, child: const Tab(text: 'En Sevilenler')),
    SizedBox(
      width: Get.width / 4,
      child: const Tab(text: 'Konular'),
    ),
    SizedBox(
      width: Get.width / 3.5,
      child: const Tab(text: 'Mentörler'),
    ),
    SizedBox(
      width: Get.width / 4.5,
      child: const Tab(text: 'Yeni'),
    ),
  ];

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: SizedBox(
                      child: TabBar(
                        onTap: (value) {
                          print(value);
                        },
                        isScrollable: true,
                        controller: _tabController,
                        tabs: _tabs
                            .map((item) => Row(
                                  children: [
                                    item,
                                    const Divider(
                                      color: Colors.transparent,
                                    )
                                  ],
                                ))
                            .toList(),
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.black,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(Get.width * 0.04),
                          color: lightWhiteColor,
                        ),
                      ),
                    )),
                SizedBox(
                  height: Get.width / 2.5,
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          DocumentSnapshot snap = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                AppointmentBottomSheet(context, snap);
                              },
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
                                        image: DecorationImage(image: NetworkImage(snap["image"]), fit: BoxFit.cover)),
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
                                          snap["username"],
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500, fontSize: Get.width / 20, overflow: TextOverflow.ellipsis),
                                        ),
                                        SizedBox(
                                          height: Get.width * 0.1,
                                        ),
                                        Text(
                                          (snap.data()! as dynamic)["occupation"] ?? "null",
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: Get.width / 30, fontWeight: FontWeight.w300, overflow: TextOverflow.ellipsis),
                                        ),
                                        const StarsWidget()
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          );
  }
}
