import 'package:agri_intell/Screens/Signup/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:agri_intell/constants.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset('assets/images/background.jpg', fit: BoxFit.fill),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 242, 243, 242).withOpacity(0.5),
            borderRadius: BorderRadius.circular(30.0),
          ),
          margin: const EdgeInsets.only(
            left: 30,
            top: 50,
            right: 10,
            bottom: 20,
          ),
          width: 350,
          height: 600,
        ),
        Container(
          margin: const EdgeInsets.all(50),
          // width: 300,
          //height: 300,
          child: const SignUpForm(),
        )
      ],
    ));
  }
}
