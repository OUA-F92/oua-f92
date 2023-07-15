import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoru/ui/home/widgets/radial_graph_widget.dart';

import '../../../utils/colors.dart';

// ignore: camel_case_types
class graphCardWidget extends StatelessWidget {
  const graphCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<ChartData> data = [
      ChartData('Feb', 10),
      ChartData('Feb', 5),
    ];

    return Container(
        decoration: BoxDecoration(color: const Color(0xffd9d9d9), borderRadius: BorderRadius.circular(15)),
        width: Get.width,
        height: Get.width * 0.4,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: '48',
                          style: TextStyle(
                              color: Colors.black, fontSize: Get.width * 0.08, fontWeight: FontWeight.w700, fontFamily: "Poppins"),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Gün',
                              style: TextStyle(
                                  fontSize: Get.width * 0.05,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  color: const Color(0xff898989)),
                            )
                          ]),
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: purpleColor, borderRadius: BorderRadius.circular(10)),
                          height: Get.width * 0.03,
                          width: Get.width * 0.08,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Mentör",
                          style: TextStyle(
                            fontSize: Get.width * 0.03,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(color: orangeColor, borderRadius: BorderRadius.circular(10)),
                          height: Get.width * 0.03,
                          width: Get.width * 0.08,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Danışan",
                          style: TextStyle(
                            fontSize: Get.width * 0.03,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            RadialGraphWidget(data: data),
          ],
        ));
  }
}
