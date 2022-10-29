import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../First.dart';
import '../Signup/signup_screen.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(60.0),
            child: Text(
              "Sign In",
              style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 24, 78, 26),
                  fontFamily: 'Bahnschrift SemiBold',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: const InputDecoration(
                hintText: "email adress",
                // border: OutlineInputBorder(),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(Icons.alternate_email),
                ),
              ),
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            obscureText: true,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "password",
              // border: OutlineInputBorder(),
              prefixIcon: Padding(
                padding: EdgeInsets.all(0),
                child: Icon(Icons.lock),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => First()))
              },
              child: Text(
                "Sign in".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
