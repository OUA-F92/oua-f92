import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mentoru/providers/user_provider.dart';
import 'package:mentoru/ui/discover/discover_page.dart';
import 'package:mentoru/ui/home/home_page.dart';
import 'package:mentoru/ui/login/login_page.dart';
import 'package:mentoru/ui/profile_page.dart';
import 'package:mentoru/ui/schedule/schedule_page.dart';
import 'package:mentoru/utils/colors.dart';
import 'package:mentoru/widgets/custom_nav_bar.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<InternetConnectionStatus>(
        initialData: InternetConnectionStatus.connected,
        create: (_) {
          return InternetConnectionChecker().onStatusChange;
        },
        child: MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => UserProvider()), ChangeNotifierProvider(create: (_) => UserProvider())],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: "Poppins"),
            home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      // ignore: prefer_const_constructors
                      return CustomNavBar();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    }
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: purpleColor,
                      ),
                    );
                  }

                  return EasySplashScreen(
                    logo: Image.asset(
                      "assets/image/LOGO.png",
                      width: Get.width / 5,
                    ),
                    title: Text(
                      "MentorU",
                      style: TextStyle(color: Colors.white, fontSize: Get.width / 14, fontWeight: FontWeight.w500),
                    ),
                    backgroundColor: purpleColor,
                    showLoader: true,
                    navigator: LoginPage(),
                    durationInSeconds: 5,
                    loaderColor: Colors.white,
                  );
                }),
          ),
        ));
  }
}
