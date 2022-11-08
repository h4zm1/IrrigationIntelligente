import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:irregation/Screens/Result.dart';
import 'package:irregation/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class PlantController extends GetxController {
  ValueNotifier<bool> loading = ValueNotifier(false);

  File? _image;
  get image => _image;

  @override
  onInit() {
    super.onInit();
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
    if (response.statusCode == 200 && response.data["status"] != "error") {
      Get.to(ResultPage(
        result: 5,
      ));
    } else {
      // Get.showOverlay(asyncFunction: asyncFunction)

      if (!await launchUrl(Uri.parse('https://flutter.dev'))) {
        throw 'Could not launch';
      }
    }

    loading.value = false;
    update();
  }
}
