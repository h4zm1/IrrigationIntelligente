import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screens/Login/Signin_screen.dart';
import 'constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset('assets/images/splash.png', fit: BoxFit.fill),
        ),
        Container(
          width: 400,
          height: 300,
          margin: const EdgeInsets.only(
            left: 50,
            top: 50,
            right: 130,
            //bottom: 10,
          ),
          child: Column(
            children: const [
              Text(
                'Welcome',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 50),
              ),
              Text(
                "We're glad that you are here",
                style: TextStyle(color: kPrimaryColor, fontSize: 20),
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          width: 200,
          margin: const EdgeInsets.only(
            left: 160,
            top: 660,
            right: 3,
            //bottom: 10,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text(
              "Let's get started ",
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              Get.toNamed("/");
            },
          ),
        ),
      ],
    ));
  }
}
