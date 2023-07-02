import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../../Widgets/internet_not_available.dart';

class DiscoverPage extends StatelessWidget {
  DiscoverPage({super.key});

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
                    child: Text("Discover Page"),
                  ),
                ),
        ],
      ),
    );
  }
}