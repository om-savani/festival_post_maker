import 'package:flutter/material.dart';

import '../screens/detailpage/detailpage.dart';
import '../screens/homepage/homepage.dart';
import '../screens/splashscreen/splashscreen.dart';

class AppRoutes {
  static String splashscreen = "/";
  static String homepage = "homepage";
  static String detailpage = "detailpage";

  static Map<String, Widget Function(BuildContext)> routes = {
    splashscreen: (context) => const SplashScreen(),
    homepage: (context) => const HomePage(),
    detailpage: (context) => const DetailPage(),
  };
}
