import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irregation/Screens/Result.dart';
import 'package:irregation/constants.dart';
import 'package:location/location.dart';

class InputController extends GetxController {
  ValueNotifier<bool> loading = ValueNotifier(false);
  TextEditingController himedity = TextEditingController(text: '');
  TextEditingController temperature = TextEditingController(text: '');
  TextEditingController water = TextEditingController(text: '');
  var dio = Dio();

  var _data;

  get data => _data;

  @override
  onInit() {
    super.onInit();
    _getData();
    print('rrrr');
  }

  Future<LocationData?> _getLocation() async {
    var location = new Location();
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return null;
    }

    return location.getLocation();
  }

  _getData() async {
    loading.value = true;
    var location = await _getLocation();
    if (location != null) {
      try {
        var response = await dio.get(backendUrl + "api/weather/",
            queryParameters: {
              "lat": location.latitude,
              "lon": location.longitude
            });

        _data = response.data;
        print(_data);
        himedity.text = _data['humidity']!;
        temperature.text = _data['temp']!;

        print(temperature.text);
      } catch (e) {
        print('error in get inputs ');
      }
    }
    loading.value = false;
    update();
  }

  send() async {
    loading.value = true;
    update();
    // try {
    var response = await dio.post(backendUrl + "api/input/", data: {
      "temperature": temperature.text,
      "humidity": himedity.text,
      "water": water.text,
    });

    print(response.data['result']);
    Get.to(ResultPage(
      result: response.data['result'],
    ));
    // } catch (e) {
    //   print('error in set inputs ');
    // }

    loading.value = false;
    update();
  }
}
