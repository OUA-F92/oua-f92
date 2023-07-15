import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../utils/colors.dart';

class RadialGraphWidget extends StatelessWidget {
  const RadialGraphWidget({
    super.key,
    required this.data,
  });

  final List<ChartData> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 0.4,
      width: Get.width * 0.4,
      child: SfCircularChart(palette: const [
        orangeColor,
        purpleColor,
      ], annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
            widget: Text(
              '%84',
              style: TextStyle(fontSize: Get.width * 0.05, fontWeight: FontWeight.w700, fontFamily: "Poppins"),
            ),
            verticalAlignment: ChartAlignment.center,
            horizontalAlignment: ChartAlignment.center)
      ], series: <CircularSeries>[
        RadialBarSeries<ChartData, String>(
            trackColor: const Color(0xffd2d2d2),
            trackBorderWidth: 8,
            cornerStyle: CornerStyle.bothCurve,
            gap: "5",
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.month,
            yValueMapper: (ChartData data, _) => data.times),
      ]),
    );
  }
}

class ChartData {
  ChartData(this.month, this.times);

  final String month;
  final double times;
}
