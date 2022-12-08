import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    Key? key,
    required this.result,
  }) : super(key: key);
  final String result;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 238, 247, 232),
            body: Stack(children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset('assets/images/dataa.png', fit: BoxFit.fill),
              ),
              Container(
                  width: Get.width - 80,
                  height: 200,
                  margin: const EdgeInsets.only(
                    top: 300,
                    left: 40,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffDDDDDD),
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Image(
                            image: AssetImage("assets/icons/1.png"),
                            width: 80,
                            height: 80,
                          ),
                          Text(
                            "Amount of water vaporized",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        result.toString() + "%",
                        style: const TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 45,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
              AppBar(
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                backgroundColor:
                    Colors.white.withOpacity(0), //You can make this transparent
                elevation: 0.0, //No shadow
              ),
            ])));
  }
}
