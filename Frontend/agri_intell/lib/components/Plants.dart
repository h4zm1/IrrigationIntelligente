import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:irregation/controller/PlantController.dart';

class Plants extends StatelessWidget {
  const Plants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlantController>(
      init: PlantController(),
      builder: (controller) => Container(
        margin: const EdgeInsets.only(
          left: 60,
          right: 20,
          top: 60,
        ),
        child: Column(
          children: [
            const Text(
              "Plants",
              style: TextStyle(
                  color: Color.fromARGB(255, 7, 126, 11),
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            controller.loading.value
                ? CircularProgressIndicator()
                : InkWell(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset('assets/images/apricot.png',
                          width: 110.0, height: 110.0),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
