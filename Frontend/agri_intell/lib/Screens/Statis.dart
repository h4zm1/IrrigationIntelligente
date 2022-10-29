import 'package:flutter/material.dart';
import '../constants.dart';
import 'Login/Signin_screen.dart';
import 'Plants.dart';
import 'Statis.dart';
import 'Result.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'inputs.dart';

class StatPage extends StatelessWidget {
  const StatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Stack(children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset('assets/images/dataa.png', fit: BoxFit.fill),
      ),
      Container(
        height: 900,
        width: 56,
        child: Image.asset('assets/images/left.png', fit: BoxFit.fill),
      ),
      // inputs

      // statics
      Container(
        width: 330,
        height: 520,
        margin: const EdgeInsets.only(
          left: 60,
          top: 300,
          right: 3,
          //bottom: 10,
        ),
        child: SfCalendar(),
      ),
      //
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
              onPressed: () {},
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
              onPressed: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Plants()))
              },
            ),
          ),
        ]),
      )
    ])));
  }
}
