import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:irregation/controller/PlantController.dart';

import '../constants.dart';
import 'InfoPage.dart';

class Plants extends StatelessWidget {
  const Plants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // inputs
        Container(
            width: 210,
            height: 520,
            margin: const EdgeInsets.only(
              left: 90,
              top: 120,
              right: 3,
              //bottom: 10,
            ),
            child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
                children: [
                  Text("Plants",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 50)),
                  SizedBox(height: 20),
                  Ink(
                    width: 100,
                    height: 120,
                    decoration: const BoxDecoration(
                      // borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/apple.png'),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InfoPage()));
                      },
                    ),
                  ),
                  Text(
                    "Apple",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Ink(
                    width: 100,
                    height: 120,
                    decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/apricot.jpg'),
                        )),
                    child: InkWell(
                      onTap: () {},
                    ),
                  ),
                  SizedBox(height: 30),
                  Ink(
                    width: 100,
                    height: 120,
                    decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/grape.jpg'),
                        )),
                    child: InkWell(
                      onTap: () {},
                    ),
                  ),
                ]));
  }
}
