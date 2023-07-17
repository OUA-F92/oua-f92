import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mentoru/conference/video_call.dart';
import 'package:mentoru/models/appointments_model.dart';
import 'package:mentoru/utils/colors.dart';
import 'package:mentoru/widgets/title_text_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../utils/utils.dart';
import '../../widgets/custom_button_widget.dart';
import '../discover/widgets/stars_widget.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  var userData = {};
  var assignedUserData = {};
  var eventData = {};
  List<AppointmentModel> appointments = [];
  bool isLoading = false;

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

      var eventSnap = await FirebaseFirestore.instance.collection("appointments").get();

      eventSnap.docs.forEach((element) {
        String title = element.data()["title"];
        Timestamp dateTime = element.data()["dateTime"];
        String assignedToUserId = element.data()["assignedToUserId"];
        String createdByUserId = element.data()["createdByUserId"];
        String id = element.id;

        appointments.add(AppointmentModel(
            id: id,
            title: title,
            dateTime: dateTime,
            createdByUserId: createdByUserId,
            assignedToUserId: assignedToUserId,
            assignedToUserName: ''));
      });

      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  // List<Meeting> _getDataSource() {
  //   final List<Meeting> meetings = <Meeting>[];
  //   final DateTime today = DateTime.now();
  //   final DateTime startTime = DateTime(today.year, today.month, today.day, 12, 0, 0);
  //   final DateTime endTime = startTime.add(const Duration(hours: 2));
  //   meetings.add(Meeting('Conference', startTime, endTime, orangeColor, "Diana Septini"));
  //   meetings.add(Meeting('Conference', startTime, endTime, purpleColor, "Diana Septini"));
  //   meetings.add(Meeting('Conference', DateTime(today.year, today.month, today.day, 15, 0, 0),
  //       DateTime(today.year, today.month, today.day, 15, 0, 0).add(const Duration(hours: 2)), purpleColor, "Diana Septini"));

  //   return meetings;
  // }

  List colorList = [
    purpleColor,
    orangeColor,
    const Color(0xff82d964),
    const Color(0xffe665fd),
    const Color(0xfff7980b),
    const Color(0xfffc6054)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
                      child: const TitleTextWidget(
                        title: "Etkinliklerim",
                      ),
                    ),
                    appointments.length == 0
                        ? SizedBox(
                            height: Get.height,
                            child: const Center(
                              child: Text("Henüz randevu oluşturmadınız."),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: appointments.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                future: userData["uid"] == appointments[index].createdByUserId
                                    ? FirebaseFirestore.instance.collection("users").doc(appointments[index].assignedToUserId).get()
                                    : FirebaseFirestore.instance.collection("users").doc(appointments[index].createdByUserId).get(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  DocumentSnapshot snap = snapshot.data!;
                                  return GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return DraggableScrollableSheet(
                                            expand: false,
                                            initialChildSize: 0.4,
                                            maxChildSize: 0.9,
                                            minChildSize: 0.32,
                                            builder: (context, scrollController) {
                                              return SingleChildScrollView(
                                                controller: scrollController,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(vertical: 6),
                                                                child: Text(
                                                                  snap["username"],
                                                                  style: TextStyle(fontSize: Get.width / 20, fontWeight: FontWeight.w500),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(vertical: 6),
                                                                child: Text(
                                                                  snap["occupation"],
                                                                  style: const TextStyle(color: darkGrayColor),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          CircleAvatar(
                                                            backgroundColor: Colors.grey,
                                                            backgroundImage: NetworkImage(
                                                              snap['image'],
                                                            ),
                                                            radius: Get.width / 12,
                                                          ),
                                                        ],
                                                      ),
                                                      const StarsWidget(),
                                                      const Padding(
                                                        padding: EdgeInsets.symmetric(vertical: 12),
                                                        child: TitleTextWidget(
                                                          title: "Hakkında",
                                                        ),
                                                      ),
                                                      Text(
                                                        snap["bio"],
                                                        style: TextStyle(color: darkGrayColor),
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets.symmetric(vertical: 12),
                                                        child: TitleTextWidget(
                                                          title: "E-posta",
                                                        ),
                                                      ),
                                                      Text(snap["email"]),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 15),
                                                        child: CustomButton(
                                                          isBorder: false,
                                                          isFilled: true,
                                                          onTap: () async {
                                                            Get.to(VideoConferencePage(
                                                                userId: userData["uid"],
                                                                userName: userData["username"],
                                                                conferenceId: appointments[index].id));
                                                          },
                                                          child: Center(
                                                              child: Text(
                                                            "Katıl",
                                                            style: TextStyle(
                                                                color: Colors.white, fontWeight: FontWeight.w600, fontSize: Get.width / 24),
                                                          )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        height: Get.width / 3,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                            color: colorList[index % 3], borderRadius: BorderRadius.circular(Get.width * 0.04)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  TitleTextWidget(
                                                    title: "${snap["username"]} ile online konferans",
                                                  ),
                                                  CircleAvatar(
                                                    backgroundColor: Colors.grey,
                                                    backgroundImage: NetworkImage(
                                                      snap['image'],
                                                    ),
                                                    radius: Get.width / 15,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.access_time,
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(DateFormat.yMd().format(appointments[index].dateTime.toDate().toLocal())),
                                                  Text(
                                                      " • ${DateFormat.Hm().format(appointments[index].dateTime.toDate().toLocal())} - ${DateFormat.Hm().format(appointments[index].dateTime.toDate().toLocal().add(const Duration(hours: 1)))}"),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ],
                ),
              ));
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.user);
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  String user;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  Color getUser(int index) {
    return appointments![index].user;
  }
}
