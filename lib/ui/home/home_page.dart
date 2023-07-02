import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../../widgets/internet_not_available.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  List<CircularStackEntry> data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(500.0, Colors.red[200], rankKey: 'Q1'),
        new CircularSegmentEntry(1000.0, Colors.green[200], rankKey: 'Q2'),
        new CircularSegmentEntry(2000.0, Colors.blue[200], rankKey: 'Q3'),
        new CircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'Q4'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];

  void _cycleSamples() {
    List<CircularStackEntry> nextData = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(1500.0, Colors.red[200], rankKey: 'Q1'),
          new CircularSegmentEntry(750.0, Colors.green[200], rankKey: 'Q2'),
          new CircularSegmentEntry(2000.0, Colors.blue[200], rankKey: 'Q3'),
          new CircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'Q4'),
        ],
        rankKey: 'Quarterly Profits',
      ),
    ];
    setState(() {
      _chartKey.currentState!.updateData(nextData);
    });
  }

  int selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Visibility(
            visible: Provider.of<InternetConnectionStatus>(context) ==
                InternetConnectionStatus.disconnected,
            child: InternetNotAvailable(),
          ),
          Provider.of<InternetConnectionStatus>(context) ==
                  InternetConnectionStatus.disconnected
              ? Expanded(
                  child: Center(
                    child: Text(
                      'Not connected',
                    ),
                  ),
                )
              : Expanded(
                  child: Center(
                      child: Center(
                    child: AnimatedCircularChart(
                      key: _chartKey,
                      size: const Size(200.0, 300.0),
                      initialChartData: data,
                      chartType: CircularChartType.Radial,
                      percentageValues: true,
                      holeLabel: '1/3',
                      labelStyle: new TextStyle(
                        color: Colors.blueGrey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  )),
                ),
        ],
      ),
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);
  final String xData;
  final num yData;
  final String text;
}
