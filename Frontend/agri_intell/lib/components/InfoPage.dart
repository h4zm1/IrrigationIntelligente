import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 108, 154, 62),
          ),
        ),
        Container(
          height: 630,
          width: 500,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                bottomLeft: Radius.circular(160.0)),
          ),
          child: Column(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  'assets/images/apple.png',
                  width: 320,
                  height: 320,
                )),
            Container(
              width: 300,
              height: 300,
              child: Column(
                children: [
                  const Text("Apple",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 20),
                  const Text(
                    'Apple, Malus domestica, is a deciduous tree in the family Rosaceae which is grown for its fruits, known as apples. Apple fruits are one of the most widely cultivated fruits in the world, are round (pome) in shape and range in color from green to red.',
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ]),
        ),
        Container(
          height: 200,
          width: 100,
          margin: const EdgeInsets.only(
            left: 10,
            top: 670,
            right: 3,
            //bottom: 10,
          ),
          child: Column(
            children: [
              Icon(
                Icons.straighten,
                color: Colors.white,
                size: 37,
              ),
              Text("Height",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white)),
              Text('25cm-30cm',
                  style: TextStyle(fontSize: 12, color: Colors.white))
            ],
          ),
        ),
        Container(
          height: 200,
          width: 100,
          margin: const EdgeInsets.only(
            left: 130,
            top: 670,
            right: 3,
            //bottom: 10,
          ),
          child: Column(
            children: [
              Icon(
                Icons.thermostat,
                color: Colors.white,
                size: 37,
              ),
              Text("Temperature",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white)),
              Text('22°C-30°C',
                  style: TextStyle(fontSize: 12, color: Colors.white))
            ],
          ),
        ),
        Container(
          height: 200,
          width: 100,
          margin: const EdgeInsets.only(
            left: 260,
            top: 670,
            right: 3,
            //bottom: 10,
          ),
          child: Column(
            children: [
              Icon(
                Icons.ac_unit,
                color: Colors.white,
                size: 37,
              ),
              Text("Humidity",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white)),
              Text('7L-10L',
                  style: TextStyle(fontSize: 12, color: Colors.white))
            ],
          ),
        ),
      ]),
    );
  }
}
