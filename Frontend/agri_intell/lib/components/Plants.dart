//import 'dart:html';

import 'package:flutter/material.dart';

class Plants extends StatelessWidget {
  const Plants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
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
          const Text(
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
    );
  }
}
