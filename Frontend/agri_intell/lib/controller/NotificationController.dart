import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:irregation/Screens/Result.dart';
import 'package:irregation/constants.dart';
import 'package:irregation/main.dart';
import 'package:location/location.dart';

class NotificationController extends GetxController {
  Time? time;

  List<String>? getData(String plant) {
    String? result = sharedPreferences!.getString(plant);
    if (result != null) {
      return result.split(",");
    }
    return null;
  }
}
