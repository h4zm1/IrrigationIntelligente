import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:irregation/components/Statis.dart';
import 'package:irregation/components/inputs.dart';
import 'package:irregation/constants.dart';
import 'package:irregation/controller/PageController.dart';
import 'package:irregation/controller/PlantController.dart';
import 'package:irregation/main.dart';
import 'Login/Signin_screen.dart';
import '../components/Plants.dart';

class Pages extends StatelessWidget {
  const Pages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PageControllers>(
      init: PageControllers(),
      builder: (controller) => Scaffold(
          body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          child: Stack(children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset('assets/images/dataa.png', fit: BoxFit.fill),
            ),
            Container(
              height: Get.height,
              width: 65,
              child: Image.asset('assets/images/left.png', fit: BoxFit.fill),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: controller.pageNumber == 0
                  ? StatPage()
                  : controller.pageNumber == 1
                      ? const InputsComponents()
                      : const Plants(),
            ),
            Container(
              height: Get.height,
              width: 54,
              child: Column(children: [
                SizedBox(height: 30),
                IconButton(
                  icon:
                      const Icon(Icons.power_settings_new, color: Colors.white),
                  onPressed: () {
                    sharedPreferences!.clear();
                    Get.off(SigninScreen());
                  },
                ),
                SizedBox(height: 180),
                RotatedBox(
                  quarterTurns: -1,
                  child: TextButton(
                    child: Text("Statistics",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () => {controller.setPage(0)},
                  ),
                ),
                SizedBox(height: 20),
                RotatedBox(
                  quarterTurns: -1,
                  child: TextButton(
                    child:
                        Text("Inputs", style: TextStyle(color: Colors.white)),
                    onPressed: () => {controller.setPage(1)},
                  ),
                ),
                SizedBox(height: 20),
                RotatedBox(
                  quarterTurns: -1,
                  child: TextButton(
                    child: Text("My gardin",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () => {controller.setPage(2)},
                  ),
                ),
                SizedBox(height: 20),
                RotatedBox(
                  quarterTurns: -1,
                  child: TextButton(
                    child:
                        Text("Plants", style: TextStyle(color: Colors.white)),
                    onPressed: () => {controller.setPage(3)},
                  ),
                ),
              ]),
            ),
            Container(
              width: 25,
              height: 50,
              margin: EdgeInsets.only(
                  left: 50, top: 270 + 90 * controller.pageNumber * 1.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(blurRadius: 4.0),
                  BoxShadow(color: Colors.white, offset: Offset(8, 8)),
                  BoxShadow(color: Colors.white, offset: Offset(8, -8)),
                  BoxShadow(color: Colors.white, offset: Offset(8, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(-8, 0)),
                ],
              ),
              alignment: Alignment.center,
              child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(101, 151, 60, 1),
                      borderRadius: BorderRadius.all(Radius.circular(30)))),
            ),
            Container(
              margin: EdgeInsets.only(left: 12, top: Get.size.height - 60),
              child: GetBuilder<PlantController>(
                init: PlantController(),
                builder: (controllerPlant) => SpeedDial(
                  direction: SpeedDialDirection.right,
                  icon: Icons.add,
                  activeIcon: Icons.close,
                  backgroundColor: const Color.fromRGBO(101, 151, 60, 1),
                  foregroundColor: Colors.white,
                  activeBackgroundColor: Colors.black,
                  activeForegroundColor: Colors.white,
                  visible: true,
                  closeManually: false,
                  curve: Curves.bounceIn,
                  overlayColor: Colors.black,
                  overlayOpacity: 0.5,
                  elevation: 0,
                  buttonSize: Size(40, 40),
                  shape: CircleBorder(),
                  children: [
                    SpeedDialChild(
                      child: Icon(Icons.image),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      label: 'Gallery',
                      labelStyle: TextStyle(fontSize: 18.0),
                      onTap: () =>
                          controllerPlant.pickImage(ImageSource.gallery),
                    ),
                    SpeedDialChild(
                      child: Icon(Icons.camera_alt),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      label: 'Camera',
                      labelStyle: TextStyle(fontSize: 18.0),
                      onTap: () =>
                          controllerPlant.pickImage(ImageSource.camera),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      )),
    );
  }
}
