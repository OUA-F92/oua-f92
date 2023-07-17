import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoru/providers/category_provider.dart';
import 'package:mentoru/ui/discover/widgets/categories_list_widget.dart';
import 'package:mentoru/ui/discover/widgets/horizontal_tab_list.dart';
import 'package:mentoru/ui/discover/widgets/filter_page.dart';
import 'package:mentoru/utils/colors.dart';
import 'package:mentoru/widgets/title_text_widget.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';
import '../../widgets/app_bar_with_text.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  TextEditingController textController = TextEditingController();

  List<User>? selectedUserList = [];

  Future<void> openFilterDelegate() async {
    await FilterListDelegate.show<User>(
      context: context,
      list: userList,
      selectedListData: selectedUserList,
      theme: FilterListDelegateThemeData(
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: Colors.white,
          selectedColor: Colors.red,
          selectedTileColor: const Color(0xFF649BEC).withOpacity(.5),
          textColor: Colors.blue,
        ),
      ),
      // enableOnlySingleSelection: true,
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      tileLabel: (user) => user!.name,
      emptySearchChild: const Center(child: Text('No user found')),
      // enableOnlySingleSelection: true,
      searchFieldHint: 'Search Here..',
      /*suggestionBuilder: (context, user, isSelected) {
        return ListTile(
          title: Text(user.name!),
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
          ),
          selected: isSelected,
        );
      },*/
      onApplyButtonClick: (list) {
        setState(() {
          selectedUserList = list;
        });
      },
    );
  }

  Future<void> _openFilterDialog() async {
    await FilterListDialog.display<User>(
      context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(context),
      headlineText: 'Select Users',
      height: 500,
      listData: userList,
      selectedListData: selectedUserList,
      choiceChipLabel: (item) => item!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
      onItemSearch: (user, query) {
        /// When search query change in search bar then this method will be called
        ///
        /// Check if items contains query
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },

      onApplyButtonClick: (list) {
        setState(() {
          selectedUserList = List.from(list!);
        });
        Navigator.pop(context);
      },

      /// uncomment below code to create custom choice chip
      /* choiceChipBuilder: (context, item, isSelected) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(
            color: isSelected! ? Colors.blue[300]! : Colors.grey[300]!,
          )),
          child: Text(
            item.name,
            style: TextStyle(
                color: isSelected ? Colors.blue[300] : Colors.grey[500]),
          ),
        );
      }, */
    );
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
                    IconButton(
                        onPressed: () async {
                          final list = Navigator.push(
                              context,
                              await FilterListDialog.display<User>(
                                hideSearchField: true,
                                headlineText: "İlgini çeken konuları seç",
                                context,
                                hideSelectedTextCount: true,
                                themeData: FilterListThemeData(context,
                                    choiceChipTheme: const ChoiceChipThemeData(selectedBackgroundColor: orangeColor),
                                    controlButtonBarTheme: ControlButtonBarThemeData(context,
                                        controlButtonTheme: const ControlButtonThemeData(
                                            backgroundColor: lightWhiteColor,
                                            primaryButtonBackgroundColor: lightWhiteColor,
                                            textStyle: TextStyle(color: Colors.black),
                                            primaryButtonTextStyle: TextStyle(color: Colors.black)))),
                                listData: userList,
                                selectedListData: selectedUserList,
                                choiceChipLabel: (user) => user!.name,
                                validateSelectedItem: (list, val) => list!.contains(val),
                                onItemSearch: (user, query) {
                                  return user.name!.toLowerCase().contains(query.toLowerCase());
                                },
                                onApplyButtonClick: (list) {
                                  setState(() {
                                    selectedUserList = List.from(list!);
                                  });
                                  Get.back();
                                },
                              ));
                          if (list != null) {
                            setState(() {
                              selectedUserList = List.from(list as Iterable);
                            });
                          }
                        },
                        icon: const Icon(Icons.filter_list))
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

class User {
  final String? name;
  final String? avatar;
  User({this.name, this.avatar});
}

/// Creating a global list for example purpose.
/// Generally it should be within data class or where ever you want
List<User> userList = [
  User(name: "Liderlik", avatar: "user.png"),
  User(name: "İş stratejisi", avatar: "user.png"),
  User(name: "İnovasyon", avatar: "user.png"),
  User(name: "Proje yönetimi", avatar: "user.png"),
  User(name: "Pazarlama", avatar: "user.png"),
  User(name: "Satış", avatar: "user.png"),
  User(name: "Finansal yönetim", avatar: "user.png"),
  User(name: "İnsan kaynakları", avatar: "user.png"),
  User(name: "İş geliştirme", avatar: "user.png"),
  User(name: "Girişimcilik", avatar: "user.png"),
  User(name: "Müşteri ilişkileri", avatar: "user.png"),
  User(name: "Verimlilik", avatar: "user.png"),
  User(name: "Süreç iyileştirme", avatar: "user.png"),
  User(name: "Risk yönetimi", avatar: "user.png"),
  User(name: "Operasyonlar", avatar: "user.png"),
  User(name: "E-ticaret", avatar: "user.png"),
  User(name: "Dijital pazarlama", avatar: "user.png"),
  User(name: "Veri analitiği", avatar: "user.png"),
  User(name: "Stratejik planlama", avatar: "user.png"),
  User(name: "Kriz yönetimi", avatar: "user.png"),
  User(name: "Yatırım", avatar: "user.png"),
  User(name: "Global iş yapma", avatar: "user.png"),
  User(name: "Rekabet analizi", avatar: "user.png"),
  User(name: "İş etiği", avatar: "user.png"),
  User(name: "İş güvenliği", avatar: "user.png"),
  User(name: "İşletme analizi", avatar: "user.png"),
  User(name: "Değişim yönetimi", avatar: "user.png"),
  User(name: "Müşteri deneyimi", avatar: "user.png"),
  User(name: "Kalite yönetimi", avatar: "user.png"),
  User(name: "Ekip yönetimi", avatar: "user.png"),
  User(name: "İşletme performansı", avatar: "user.png"),
  User(name: "Ürün geliştirme", avatar: "user.png"),
  User(name: "İş planlama", avatar: "user.png"),
  User(name: "Marka yönetimi", avatar: "user.png"),
  User(name: "Kurumsal iletişim", avatar: "user.png"),
  User(name: "Stratejik yönetim", avatar: "user.png"),
  User(name: "İş analitiği", avatar: "user.png"),
  User(name: "Müşteri hizmetleri", avatar: "user.png"),
  User(name: "İş süreçleri", avatar: "user.png"),
  User(name: "Teknoloji", avatar: "user.png"),
];
