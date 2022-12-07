import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irregation/components/InfoPage.dart';
import 'package:irregation/controller/PlantController.dart';
import 'package:irregation/main.dart';

import '../constants.dart';

class MyGardin extends StatelessWidget {
  const MyGardin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlantController>(
      init: new PlantController(),
      builder: (controller) => Container(
          width: Get.width - 160,
          margin: EdgeInsets.only(
            left: Get.width * 0.2,
            top: 60,
          ),
          child: Column(
            children: [
              const Text("Plants",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 50)),
              const SizedBox(height: 20),
              SingleChildScrollView(
                child: Container(
                  height: Get.height - 150,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.mygardinList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          String? result = sharedPreferences!.getString(
                              controller.mygardinList[index]["plantName"]);
                          dynamic data = [];
                          if (result != null) {
                            data = result.split(",");
                            print(result);
                          }
                          Get.to(InfoPage(
                            plant: controller.mygardinList[index],
                            data: data,
                          ));
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 200,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                    image: NetworkImage(controller
                                        .mygardinList[index]['plantImageUrl']
                                        .split(",")[0]),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: Text(
                                controller.mygardinList[index]['plantName'],
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
