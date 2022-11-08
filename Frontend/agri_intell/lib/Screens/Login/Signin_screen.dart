import 'package:flutter/material.dart';
import 'package:irregation/Screens/Login/signin_form.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

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
            top: 70,
            right: 10,
            bottom: 20,
          ),
          width: 350,
          height: 600,
          child: Container(
            margin: const EdgeInsets.all(20),
            child: const SignInForm(),
          ),
        ),
      ],
    ));
  }
}
