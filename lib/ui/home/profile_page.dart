import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../../Widgets/internet_not_available.dart';
import '../../services/auth_methods.dart';
import '../login/login_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Profile Page"),
                        IconButton(
                            onPressed: () async {
                              await AuthMethods().signOut();
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            icon: Icon(Icons.logout_outlined)),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
