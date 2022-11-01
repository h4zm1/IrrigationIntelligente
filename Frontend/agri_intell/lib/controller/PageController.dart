import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageControllers extends GetxController {
  ValueNotifier<bool> loading = ValueNotifier(false);

  var _pageNumber = 1;

  get pageNumber => _pageNumber;

  @override
  onInit() {
    super.onInit();
  }

  setPage(int p) {
    _pageNumber = p;

    update();
  }
}
