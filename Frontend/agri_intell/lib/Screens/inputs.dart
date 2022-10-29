import 'package:flutter/material.dart';
import '../constants.dart';
import 'Login/Signin_screen.dart';
import 'Plants.dart';
import 'Statis.dart';
import 'Result.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Inputs extends StatelessWidget {
  const Inputs({Key? key}) : super(key: key);

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
      Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Temperature",
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  const TextField(
                    style: TextStyle(height: 0.0),
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(0, 22, 97, 37),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                          color: kPrimaryColor, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  const TextField(
                    style: TextStyle(height: 0.0),
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(0, 232, 227, 227),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                          color: kPrimaryColor, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  const TextField(
                    style: TextStyle(height: 0.0),
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(0, 232, 227, 227),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      filled: true,
                      suffixIcon: Icon(
                        Icons.water_drop,
                        color: kPrimaryColor,
                      ),
                    ),
                    cursorColor: kPrimaryColor,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    child: Text('Send'),
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size(300, 60)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 8, 63, 10)),
                    ),
                    onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ResultPage()))
                    },
                  )

                  //const SizedBox(height: defaultPadding),
                ],
              ))),

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
