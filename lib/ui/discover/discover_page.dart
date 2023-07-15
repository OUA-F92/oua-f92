import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoru/providers/category_provider.dart';
import 'package:mentoru/ui/discover/widgets/categories_list_widget.dart';
import 'package:mentoru/ui/discover/widgets/horizontal_tab_list.dart';
import 'package:mentoru/utils/colors.dart';
import 'package:mentoru/widgets/title_text_widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bar_with_text.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addData();
  }

  void addData() async {
    CategoyProvider categoryProvider = Provider.of(context, listen: false);
    await categoryProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textController,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: Get.width / 24),
                            prefixIcon: Container(
                              margin: EdgeInsets.symmetric(vertical: Get.width * 0.05),
                              child: Image.asset(
                                'assets/icons/search.png',
                                color: darkGrayColor,
                              ),
                            )),
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.filter_list))
                  ],
                ),
              ),
              const TitleTextWidget(
                title: "Popüler 🔥",
              ),
              const HorizontalTabList(),
              const TitleTextWidget(
                title: "Kategoriler",
              ),
              const CategoriesListWidget(),
            ],
          ),
        )),
      ),
    ));
  }
}
