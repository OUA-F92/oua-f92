import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mentoru/services/auth_methods.dart';
import 'package:mentoru/ui/login/login_page.dart';
import 'package:provider/provider.dart';

import '../../widgets/internet_not_available.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Visibility(
            visible: Provider.of<InternetConnectionStatus>(context) ==
                InternetConnectionStatus.disconnected,
            child: const InternetNotAvailable(),
          ),
          Provider.of<InternetConnectionStatus>(context) ==
                  InternetConnectionStatus.disconnected
              ? const Expanded(
                  child: Center(
                    child: Text(
                      'Not connected',
                    ),
                  ),
                )
              : Expanded(
                  child: Center(
                    child: IconButton(
                        onPressed: () async {
                          await AuthMethods().signOut();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.logout_outlined)),
                  ),
                ),
        ],
      ),
    );
  }
}
