import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../models/user.dart';
import '../../../utils/colors.dart';
import 'discover_profile_card_widget.dart';

class HorizontalTabList extends StatefulWidget {
  const HorizontalTabList({super.key});

  @override
  State<HorizontalTabList> createState() => _HorizontalTabListState();
}

class _HorizontalTabListState extends State<HorizontalTabList> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          const DiscoverProfileCardWidget()
        ],
      ),
    );
  }
}
