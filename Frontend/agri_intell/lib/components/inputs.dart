import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irregation/constants.dart';
import 'package:irregation/controller/InputController.dart';
import 'package:irregation/controller/PlantController.dart';

class InputsComponents extends StatelessWidget {
  const InputsComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputController>(
        init: InputController(),
        builder: (controllerInputs) => Container(
            width: 330,
            height: 520,
            margin: const EdgeInsets.only(
              left: 60,
              top: 300,
              right: 3,
              //bottom: 10,
            ),
            child: Padding(
                padding: EdgeInsets.all(30),
                child: GetBuilder<PlantController>(
                  init: PlantController(),
                  builder: (pcontroller) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      pcontroller.mygardinList != null &&
                              pcontroller.mygardinList.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Plant",
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  width: Get.width,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: pcontroller
                                        .mygardinList.first["plantName"],
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style:
                                        const TextStyle(color: kPrimaryColor),
                                    underline: Container(
                                      height: 2,
                                      color: kPrimaryColor,
                                    ),
                                    onChanged: (String? value) {
                                      if (value != null) {
                                        controllerInputs.pant.text = value;
                                      }
                                    },
                                    items: pcontroller.mygardinList
                                        .map<DropdownMenuItem<String>>(
                                            (dynamic value) {
                                      return DropdownMenuItem<String>(
                                        value: value["plantName"],
                                        child: Text(value["plantName"]),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            )
                          : Container(),

                      const Text("Temperature",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      TextField(
                        style: TextStyle(height: 0.0),
                        controller: controllerInputs.temperature,
                        decoration: const InputDecoration(
                          fillColor: Color.fromARGB(0, 22, 97, 37),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          suffixIcon: Icon(
                            Icons.thermostat,
                            color: kPrimaryColor,
                          ),
                        ),
                        cursorColor: kPrimaryColor,
                      ),
                      const SizedBox(height: 10),
                      const Text("Hemidity",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      TextField(
                        style: TextStyle(height: 0.0),
                        controller: controllerInputs.himedity,
                        decoration: const InputDecoration(
                          fillColor: Color.fromARGB(0, 232, 227, 227),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          suffixIcon: Icon(
                            Icons.ac_unit,
                            color: kPrimaryColor,
                          ),
                        ),
                        cursorColor: kPrimaryColor,
                      ),
                      SizedBox(height: 10),
                      const Text("Quantity water",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      TextField(
                        style: const TextStyle(height: 0.0),
                        decoration: const InputDecoration(
                          fillColor: Color.fromARGB(0, 232, 227, 227),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          filled: true,
                          suffixIcon: Icon(
                            Icons.water_drop,
                            color: kPrimaryColor,
                          ),
                        ),
                        cursorColor: kPrimaryColor,
                        controller: controllerInputs.water,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(const Size(300, 60)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 8, 63, 10)),
                        ),
                        onPressed: () => {controllerInputs.send()},
                        child: controllerInputs.loading.value
                            ? const CircularProgressIndicator()
                            : const Text('Send'),
                      )

                      //const SizedBox(height: defaultPadding),
                    ],
                  ),
                ))));
  }
}
