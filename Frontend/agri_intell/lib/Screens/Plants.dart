//import 'dart:html';

import 'package:flutter/material.dart';
import '../constants.dart';
import 'Login/Signin_screen.dart';
import 'Statis.dart';
import 'Result.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'inputs.dart';

class Plants extends StatelessWidget {
  const Plants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Stack(children: [
      Container(
        height: 900,
        width: 56,
        child: Image.asset('assets/images/left.png', fit: BoxFit.fill),
      ),
      // inputs
      Container(
        width: 330,
        height: 520,
        margin: const EdgeInsets.only(
          left: 10,
          top: 50,
          right: 3,
          //bottom: 10,
        ),
        child: Column(
          children: [
            Text(
              "Plants",
              style: TextStyle(
                  color: Color.fromARGB(255, 7, 41, 8),
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            InkWell(
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
      Container(
        height: 900,
        width: 54,
        child: Column(children: [
          SizedBox(height: 30),
          IconButton(
            icon: const Icon(Icons.power_settings_new, color: Colors.white),
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SigninScreen()))
            },
          ),
          SizedBox(height: 260),
          RotatedBox(
            quarterTurns: -1,
            child: FlatButton(
              child: Text("Statistics", style: TextStyle(color: Colors.white)),
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StatPage()))
              },
            ),
          ),
          SizedBox(height: 20),
          RotatedBox(
            quarterTurns: -1,
            child: FlatButton(
              child: Text("Inputs", style: TextStyle(color: Colors.white)),
              onPressed: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Inputs()))
              },
            ),
          ),
          SizedBox(height: 20),
          RotatedBox(
            quarterTurns: -1,
            child: FlatButton(
              child: Text("Plants", style: TextStyle(color: Colors.white)),
              onPressed: () {},
            ),
          ),
        ]),
      )
    ])));
  }
}
