import 'package:flutter/cupertino.dart';
import 'package:irregation/Screens/Login/Signin_form.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irregation/Screens/Login/Signin_screen.dart';
import 'package:irregation/Screens/pages.dart';

import 'package:irregation/constants.dart';
import 'package:irregation/main.dart';

import '../Screens/Result.dart';

class LoginController extends GetxController {
  ValueNotifier<bool> loading = ValueNotifier(false);
  TextEditingController username = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');
  TextEditingController email = TextEditingController(text: '');
  var dio = Dio();
  send() async {
    loading.value = true;
    update();

    try {
      var response = await dio.post(backendUrl + "api/account/", data: {
        "username": username.text,
        "password": password.text,
      });
      print(response);
      if (response.data["login"] == "true") {
        sharedPreferences!.setInt("id", response.data["id"]);
        sharedPreferences!.setString("email", response.data["email"]);
        sharedPreferences!.setString("username", response.data["username"]);
        Get.to(Pages());
      } else {
        Get.defaultDialog(
            title: "Login failed",
            middleText: "Your username or  password are incorrect");
      }
    } catch (e) {
      print(e);
    }

    loading.value = false;
    update();
  }

  register() async {
    loading.value = true;
    update();

    try {
      var response = await dio.get(backendUrl + "api/account/",
          queryParameters: {
            "username": username.text,
            "email": email.text,
            "passord": password.text
          });
      print(response);
      if (response.data["success"] == true) {
        Get.to(SigninScreen());
        username.text = "";
        email.text = "";
        password.text = "";
      } else {
        Get.defaultDialog(
            title: "Register failed",
            middleText: "Your username or  password are incorrect");
      }
    } catch (e) {
      print(e);
    }

    loading.value = false;
    update();
  }
}
