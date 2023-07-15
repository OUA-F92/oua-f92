import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/my_plan_model.dart';
import '../../../utils/colors.dart';

class MyPlanWidget extends StatefulWidget {
  const MyPlanWidget({super.key});

  @override
  State<MyPlanWidget> createState() => _MyPlanWidgetState();
}

class _MyPlanWidgetState extends State<MyPlanWidget> {
  List colorList = [purpleColor, orangeColor, greenColor];

  List<MyPlan> myPlanList = [
    MyPlan(
        "Diana Septini 1",
        "14 Haziran 2023 • 16:00 - 17:00",
        "nam aliquam sem et tortor consequat id porta nibh venenatis cras sed felis eget velit",
        "Mentör",
        "Meta’da Yazılım Mühendisi",
        false),
    MyPlan(
        "Diana Septini 1",
        "14 Haziran 2023 • 16:00 - 17:00",
        "nam aliquam sem et tortor consequat id porta nibh venenatis cras sed felis eget velit",
        "Mentör",
        "Meta’da Yazılım Mühendisi",
        false),
    MyPlan(
        "Diana Septini 1",
        "14 Haziran 2023 • 16:00 - 17:00",
        "nam aliquam sem et tortor consequat id porta nibh venenatis cras sed felis eget velit",
        "Mentör",
        "Meta’da Yazılım Mühendisi",
        false),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var color = colorList[index % 3];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ExpansionTileCard(
            duration: const Duration(milliseconds: 300),
            expandedTextColor: Colors.black,
            elevation: 0,
            baseColor: color,
            expandedColor: color,
            onExpansionChanged: (value) {
              setState(() {
                myPlanList[index].isExpanded = value;
              });
            },
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  myPlanList[index].name,
                  maxLines: 2,
                  style: TextStyle(fontSize: Get.width / 24, overflow: TextOverflow.ellipsis),
                ),
                Visibility(
                  visible: myPlanList[index].isExpanded,
                  child: Text(
                    "nam aliquam sem et tortor consequat id porta nibh venenatis cras sed felis eget velit",
                    maxLines: 3,
                    style: TextStyle(color: darkGrayColor, fontSize: Get.width / 28, overflow: TextOverflow.ellipsis),
                  ),
                ),
                Visibility(
                  visible: !myPlanList[index].isExpanded,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        myPlanList[index].time,
                        maxLines: 2,
                        style: TextStyle(color: darkGrayColor, fontSize: Get.width / 28, overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/conference.png",
                            width: Get.width / 18,
                          ),
                          Text(
                            "Online",
                            style: TextStyle(fontSize: Get.width / 28, overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: Get.width,
                  width: Get.width,
                  decoration: BoxDecoration(color: lightWhiteColor, borderRadius: BorderRadius.circular(Get.width * 0.04)),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
