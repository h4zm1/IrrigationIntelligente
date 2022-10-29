import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../First.dart';
import '../Login/Signin_screen.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(50.0),
            child: Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 24, 78, 26),
                  fontFamily: 'Bahnschrift SemiBold',
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Full name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(0),
                child: Icon(Icons.account_circle),
              ),
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
                hintText: "Email adress",
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
              hintText: "Password",
              prefixIcon: Padding(
                padding: EdgeInsets.all(0),
                child: Icon(Icons.lock),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SigninScreen()))
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SigninScreen();
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
