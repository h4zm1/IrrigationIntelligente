import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:irregation/Screens/pages.dart';
import 'package:irregation/main.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    print(sharedPreferences!.getString('id'));
    if ((sharedPreferences!.getString('id') != null)) {
      return RouteSettings(name: "/home");
    }
  }
}
