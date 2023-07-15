import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoru/ui/home/widgets/graph_card_widget.dart';
import 'package:mentoru/ui/home/widgets/my_plan_widget.dart';

import '../../widgets/appbar_with_name_widget.dart';
import 'widgets/popular_card_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const appbar_with_name(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Aktivitelerim",
                  style: TextStyle(fontSize: Get.width / 24, fontWeight: FontWeight.w500),
                ),
              ),
              const graphCardWidget(),
              SizedBox(
                height: Get.width * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popüler",
                      style: TextStyle(fontSize: Get.width / 24, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              "Hepsini Gör",
                              style: TextStyle(fontSize: Get.width / 33),
                            ),
                            const Icon(Icons.keyboard_arrow_down_rounded)
                          ],
                        ))
                  ],
                ),
              ),
              const PopularCardListWidget(),
              SizedBox(
                height: Get.width * 0.1,
              ),
              Text(
                "Planım",
                style: TextStyle(fontSize: Get.width / 24, fontWeight: FontWeight.w500),
              ),
              const MyPlanWidget()
            ],
          ),
        ),
      ),
    );
  }
}
