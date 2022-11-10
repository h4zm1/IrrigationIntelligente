import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:irregation/Screens/Result.dart';
import 'package:irregation/components/InfoPage.dart';
import 'package:irregation/constants.dart';
import 'package:irregation/main.dart';
import 'package:url_launcher/url_launcher.dart';

class PlantController extends GetxController {
  ValueNotifier<bool> loading = ValueNotifier(false);

  File? _image;
  get image => _image;
  var guidList = [];
  var mygardinList = [];

  @override
  onInit() {
    super.onInit();
    getGuideList();
    getMyGardenList();
  }

  Future pickImage(ImageSource sourcei) async {
    loading.value = true;
    update();

    final image = await ImagePicker().pickImage(source: sourcei);
    if (image == null) return;

    // try {
    _image = File(image.path);
    var dio = Dio();
    String fileName = _image!.path.split('/').last;
    print(fileName);
    FormData formData = FormData.fromMap({
      "picture": await MultipartFile.fromFile(_image!.path, filename: fileName),
      "userId": sharedPreferences!.getInt("id")
    });
    var response = await dio.post(
      backendUrl + "api/guide/",
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    print(response.data);
    if (response.statusCode == 200 && response.data["status"] == null) {
      Get.to(InfoPage(
        plant: response.data,
      ));
      getMyGardenList();
    } else if (response.data["status"] == "not found") {
      if (!await launchUrl(Uri.parse(
          'https://www.google.com/search?q=' + response.data["name"]))) {
        throw 'Could not launch';
      }
    } else {
      //gfdsssssssssss
      print(response);
    }

    loading.value = false;
    update();
  }

  Future getGuideList() async {
    loading.value = true;
    update();

    // try {

    var dio = Dio();
    var response = await dio.get(
      backendUrl + "api/guide/",
    );
    print(response.data);
    if (response.statusCode == 200) {
      guidList = response.data;
    } else {
      // Get.showOverlay(asyncFunction: asyncFunction)
    }

    loading.value = false;
    update();
  }

  Future getMyGardenList() async {
    loading.value = true;
    update();

    // try {

    var dio = Dio();
    var response = await dio.get(backendUrl + "api/garden/", queryParameters: {
      "userId": sharedPreferences!.getInt("id"),
    });

    if (response.statusCode == 200) {
      mygardinList = response.data;
    } else {
      // Get.showOverlay(asyncFunction: asyncFunction)
    }

    loading.value = false;
    update();
  }
}
